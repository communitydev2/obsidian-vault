

## LanguageDropdown

- if selectedCardCategory is 1 (cards for trade), then hide language dropdown by setting useStateStoreWrapper.setShowLanguageDropdown inside cardcategory OnChange

 

##  #reactError Maximum update depth exceeded.


```
Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops.
```
Solution - set it once (inside an onChange or onClick)



## Card Category Drop down

In mantine in the default value is a string as seen in the documentation and however whenever I try and select the value 0 on the table it just returns null and I have no idea why this is doing that and so I am now looking into it

