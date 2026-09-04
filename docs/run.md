# Commands

### Tom cat

```
& "$env:CATALINA_HOME\bin\version.bat"
```
Run commands:
```
& "$env:CATALINA_HOME\bin\startup.bat"
```

Webpage url to search:

```
http://localhost:8080
```

Email: admin@campus.local
Password: admin123

## cms tomcat force

Copy-Item ".\target\cms.war" `
>> "C:\Tomcat\apache-tomcat-11.0.25\webapps\cms.war" -Force

mvn package