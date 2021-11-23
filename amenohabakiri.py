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

file = open("Home.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("Home.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("TeamCharts.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("TeamCharts.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("SelectedEmployeeCharts.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("SelectedEmployeeCharts.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("ManagerCharts.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ManagerCharts.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("CurrentUserCharts.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("CurrentUserCharts.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("SignUp.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("SignUp.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("Logout.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("Logout.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("Login.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("Login.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("UserTeamManager.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UserTeamManager.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("UserManagementComponent.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UserManagementComponent.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("TeamManager.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("TeamManager.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("SideBarComponent.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("SideBarComponent.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("AdminComponent.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("AdminComponent.vue", 'w') as file:
        file.write(fileData)
file.close()