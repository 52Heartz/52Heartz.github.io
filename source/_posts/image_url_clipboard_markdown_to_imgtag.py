# 使用方法：把要处理的文本复制到剪切板中，然后运行这个脚本一次。
# 程序会自动读取剪切板内容进行处理，处理完之后再放到剪切板中
# 
# 本程序会把markdown的图片链接格式自动转换为HTML的<img>标签
# 打草稿的时候使用相对路径，本程序会自动把相对路径的文件夹的名字删掉，只保留文件名
# 这样博客可以正常生成链接。

import pyperclip
import re

text_to_process = pyperclip.paste()
text_to_process = re.sub(r'!\[(.+)\]\(.+\/(.+)\)', r'<img src="\2" alt="\1" width="500px">', text_to_process, 0, re.MULTILINE)
pyperclip.copy(text_to_process)