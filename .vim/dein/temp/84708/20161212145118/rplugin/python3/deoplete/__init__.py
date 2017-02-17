# ============================================================================
# FILE: __init__.py
# AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
# License: MIT license
# ============================================================================

import neovim
import os
import re

from deoplete import logger
from deoplete.deoplete import Deoplete
from glob import glob


@neovim.plugin
class DeopleteHandlers(object):

    def __init__(self, vim):
        self.__vim = vim

    @neovim.function('_deoplete', sync=True)
    def init_python(self, args):
        self.__deoplete = Deoplete(self.__vim)
        self.__vim.vars['deoplete#_channel_id'] = self.__vim.channel_id

        # Check neovim-python version.
        version = 'unknown'
        python_dir = os.path.dirname(os.path.dirname(neovim.__file__))
        base = python_dir + '/neovim-*/'
        for metadata in glob(base + 'PKG-INFO') + glob(base + '/METADATA'):
            with open(metadata, 'r', errors='replace') as f:
                for line in f:
                    m = re.match('Version: (.+)', line)
                    if m:
                        version = m.group(1)
        self.__vim.vars['deoplete#_neovim_python_version'] = version

    @neovim.rpc_export('deoplete_enable_logging', sync=True)
    def enable_logging(self, level, logfile):
        logger.setup(self.__vim, level, logfile)
        self.__deoplete.debug_enabled = True

    @neovim.rpc_export('deoplete_auto_completion_begin')
    def completion_begin(self, context):
        context['rpc'] = 'deoplete_auto_completion_begin'
        self.__deoplete.completion_begin(context)

    @neovim.rpc_export('deoplete_manual_completion_begin', sync=True)
    def manual_completion_begin(self, context):
        context['rpc'] = 'deoplete_manual_completion_begin'
        self.__deoplete.completion_begin(context)

    @neovim.rpc_export('deoplete_on_event')
    def on_event(self, context):
        context['rpc'] = 'deoplete_on_event'
        self.__deoplete.on_event(context)