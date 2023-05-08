import os

# 多语言中文数据文件位置
dataFile = "../lib/lang/zh_CN.dart"
# 生成的Translate类位置
filepath = "../lib/lang/translate.dart"

# 判断文件是否存在，存在需要删除
if os.path.exists(filepath) == True :
    os.remove(filepath)

f1 = open(dataFile, encoding='utf-8')
content = f1.read()


headerString = content.split('const Map<String, String> zh_CN = {')[0]

content = content.split('const Map<String, String> zh_CN = {')[1]

# print(content)

c = content
c = c.split('\n')
memoList = []
otherList = []
for data in c:
    # print(data)
    if data.find('//') > -1 or data.find('///') > -1:
        data = data + '",'
    otherList.append(data)

content = "\n".join(otherList)
# print(content)

content = content.replace('};', '')
content = content.replace('\n', '')
content = content.replace(' ', '')
datalist = content.split('",')

f = open(filepath, mode='w+')

string = ''
# string += "import 'package:get/get.dart';\n\n"
string += "class Translate {\n"

# print(datalist)

for data in datalist:
    d = data.split('":')

    name = d[0]
    name = name.replace('"', '')
    name = name.replace("'", '')
    name = name.replace('-', '_')

    namelist = name.split('_')
    namelist2 = []
    i = 0
    for c in namelist:
        # print(c)
        if len(c) > 0:
            a = c[0:1]
            b = c[1:len(c)]
            if i > 0:
                c =  a.upper() + b
            else:
                c =  a + b
            namelist2.append(c)
        i = i + 1

    name = ''.join(namelist2)

    # print(name)
    if name.find('//') != -1:
        string += "\n  " + name + '\n'
    elif name != '':
        d = data.split(':')
        h = d[1]
        h = h.replace("'", "")
        h = h.replace('"', "")
        string += '\n  /// ' + h + "\n"
        string += '  static String ' + name + ' = ' + d[0] + ';\n'

string += "}\n"

f.write(string)
f.close()

print('> ok')

