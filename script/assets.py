import os

def createFile(dirPath, filepath) :
    print('> 开始生成 `'+dirPath+'` 下的文件')

    # imagesDir = os.getcwd()+dirPath

    f1 = open(filepath, encoding='utf-8')
    content = f1.read()
    content = content.split('/* 自动生成代码用，勿删 */')
    # print(content)

    f = open(filepath, mode='w+')

    string = ''
    for root, dirs, files in os.walk(dirPath):
            for file in files:
                filePath = os.path.join(root,file);
                # print(filePath)
                if filePath.find('.DS_Store') == -1 :
                    filePath = filePath.split('assets')[1]
                    filePath = 'assets' + filePath

                    name = filePath.split('/')
                    name = name[len(name) - 1]
                    name = name.split('.')[0]
                    name = name.replace('-', '_')

                    if name != '' :
                        string += '  static const String {1} = "{0}";\n'.format(filePath, name)

    content[1] = string
    # print(string)
    # print(content)
    content = "/* 自动生成代码用，勿删 */".join(content)

    f.write(content)
    f.close()

createFile("../assets/images", "../lib/const/image_const.dart")
createFile("../assets/fonts", "../lib/const/font_const.dart")
createFile("../assets/svg", "../lib/const/svg_const.dart")
# createFile("../assets/json", "../lib/const/json_const.dart")

print('> ok')

