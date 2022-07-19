from powerline_shell.utils import BasicSegment


class Segment(BasicSegment):
    def add_to_powerline(self):
        bg = self.powerline.theme.PATH_BG
        if self.powerline.args.prev_error == 0:
            fg = 208 # bright orange
            show = '☀' # sun icon
        elif self.powerline.args.prev_error == 1:
            fg = 109 # bright blue
            show = '☂' # rain icon
        else:
            fg = self.powerline.theme.CMD_FAILED_BG
            show = str(self.powerline.args.prev_error)

        self.powerline.append(' %s ' % show, fg, bg)
