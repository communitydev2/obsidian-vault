https://stackoverflow.com/questions/62415804/how-to-prevent-netlify-from-treating-warnings-as-errors-because-process-env-ci

Go to environment variables in netlify
add variable

name CI
value - false

```
CI=false yarn run build

```