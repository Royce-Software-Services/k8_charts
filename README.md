### eks-istio deployment chart:
- Add to repo via submodule, requires repo SSH PUB KEY
```
git submodule add git@bitbucket.org:pave-mobility/k8_charts.git chart
```
 
# Supports AWS Secrets
 - Set AWS Secret as ENV Var
 - k8s_use_secrets must set enabled (true/false)

# Helm Values 
```
k8s_use_secrets:
  enabled: true
  
envFromSecrets:                         # sets aws secrets value as ENV VAR
  DB_USERNAME:
    name: dbsecret
    key: DB_USERNAME              
    
k8s_secrets:
  DBSECRET:
    name: dbsecret
    key: stg/dbsecret                   # AWS Secrets Path/Value
    paths:
     - pathname: username
       pathalias: dbusername
       key: DB_USERNAME
```

# AWS Secrets
```
{"username":"eticoparking"}
```



# Dev Notes
- run template for dev

``` 
helm template -f ../../blue-values.yaml app-deploy-template
```

# Manual upgrade (depcreated, use pipeline)
```
helm upgrade --install <appname> ./charts/app-deploy-template -f values.yaml -n <namespace>
```
# k8_charts
