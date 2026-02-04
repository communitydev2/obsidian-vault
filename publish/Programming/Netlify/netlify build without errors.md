https://stackoverflow.com/questions/62415804/how-to-prevent-netlify-from-treating-warnings-as-errors-because-process-env-ci

https://docs.netlify.com/build/configure-builds/troubleshooting-tips/#build-fails-on-warning-message

Go to environment variables in netlify
add variable

name CI
value - false

```
CI='' yarn run build

```