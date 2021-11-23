import os
path = os.getcwd()
frontPath = path + "/" + "T-POO-700_theme02_project"
srcPath = frontPath + "/" + "src"
componentsPath = srcPath + "/" + "components"

os.chdir(frontPath)
os.chdir(srcPath)
os.chdir(componentsPath)
print(os.getcwd())

hostName = "localhost:4000"
rightHostname = "35.246.32.237:4000"

file = open("ChartContainer.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ChartContainer.vue", 'w') as file:
        file.write(fileData)
file.close()
        
file = open("ClockComponent.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ClockComponent.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("UserComponent.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UserComponent.vue", 'w') as file:
        file.write(fileData)
file.close()
        
file = open("WorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("WorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("WorkingTimes.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("WorkingTimes.vue", 'w') as file:
        file.write(fileData)
file.close()
