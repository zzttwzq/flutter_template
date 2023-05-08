import os
import sys

def createPage(fileDir, fileName, fileNameUpCase) :
    f = open(fileDir + fileName + "/" + fileName + ".dart", mode='w+')
    string = ''
    string += "import 'package:app/UI/custom_appbar.dart';\n"
    string += "import 'package:app/utils/ui_util.dart';\n"
    string += "import 'package:flutter/material.dart';\n"
    string += "import 'package:get/get.dart';\n"
    string += "\n"
    string += "class " + fileNameUpCase + " extends GetView with BaseUiMixin {\n"
    string += "  const " + fileNameUpCase + "({super.key});\n"
    string += "\n"
    string += "  @override\n"
    string += "  Widget build(BuildContext context) {\n"
    string += "    return Scaffold(\n"
    string += "        appBar: CustomAppBar.regularAppBar('title'),\n"
    string += "        body: SafeArea(\n"
    string += "          child: Container(),\n"
    string += "        ));\n"
    string += "  }\n"
    string += "}\n"
    f.write(string)
    f.close()

def createModel(fileDir, fileName, fileNameUpCase) :
    f = open(fileDir + fileName + "/" + fileName + "_model.dart", mode='w+')
    string = ''
    string += "class " + fileNameUpCase + "Model {\n"
    string += "\n"
    string += "}\n"
    f.write(string)
    f.close()

def createController(fileDir, fileName, fileNameUpCase) :
    f = open(fileDir + fileName + "/" + fileName + "_controller.dart", mode='w+')

    a = fileNameUpCase[0:1]
    b = fileNameUpCase[1:len(fileNameUpCase)]
    c = a.lower() + b

    string = ''
    string += "import 'package:app/views/" + fileName + "/" + fileName + "_model.dart';\n"
    string += "import 'package:get/get.dart';\n"
    string += "\n"
    string += "class " + fileNameUpCase + "Controller extends GetxController {\n"
    string += "  Rx<" + fileNameUpCase + "Model> " + c + "Model = " + fileNameUpCase + "Model().obs;\n"
    string += "\n"
    string += "  @override\n"
    string += "  void onReady() {\n"
    string += "    super.onReady();\n"
    string += "  }\n"
    string += "\n"
    string += "  @override\n"
    string += "  void onClose() {\n"
    string += "    super.onClose();\n"
    string += "  }\n"
    string += "}\n"
    f.write(string)
    f.close()

def createBinding(fileDir, fileName, fileNameUpCase) :
    f = open(fileDir + fileName + "/" + fileName + "_binding.dart", mode='w+')
    string = ''
    string += "import 'package:app/views/" + fileName + "/" + fileName + "_controller.dart';\n"
    string += "import 'package:get/get.dart';\n"
    string += "\n"
    string += "class " + fileNameUpCase + "Binding extends Bindings {\n"
    string += "\n"
    string += "  @override\n"
    string += "  void dependencies() {\n"
    string += "    Get.lazyPut(() => " + fileNameUpCase + "Controller());\n"
    string += "  }\n"
    string += "}\n"
    f.write(string)
    f.close()

def main() :
    upname = ""
    if len(sys.argv) < 2:
        print('请输入文件名，用_分开单词。')
        return

    name = sys.argv[1]
    fileDir = 'lib/views/'
    if name == '':
        return

    if name.find('_') == -1 :
        a = name[0:1]
        a = a.upper()
        a1 = name[1:len(name)]
        upname = a + a1
    else:
        a = name.split('_')[0][0:1]
        a = a.upper()
        a1 = name.split('_')[0][1:len(name)]
        b = name.split('_')[1][0:1]
        b = b.upper()
        b1 = name.split('_')[1][1:len(name)]
        upname = a + a1 + b + b1

    # 创建目录
    fileDir1 = fileDir + name
    if os.path.exists(fileDir1) == False:
        os.makedirs(fileDir1)

    # 创建 view
    createPage(fileDir, name, upname)

    # 创建 model
    createModel(fileDir, name, upname)

    # 创建 controller
    createController(fileDir, name, upname)

    # 创建 binding
    createBinding(fileDir, name, upname)
    
    print('>>> ok')

main()
    