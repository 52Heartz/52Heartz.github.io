# 使用方法：把要处理的文本复制到剪切板中，然后运行这个脚本一次。
# 程序会自动读取剪切板内容进行处理，处理完之后再放到剪切板中

import pyperclip
import re

text_to_process = pyperclip.paste()
text_to_process = re.sub(r'!\[(.+)\]\(.+\/(.+)\)', r'<img src="\2" alt="\1" width="500px">', text_to_process, 0, re.MULTILINE)
pyperclip.copy(text_to_process)