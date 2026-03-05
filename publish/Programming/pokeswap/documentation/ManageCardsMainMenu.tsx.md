

## LanguageDropdown

- if selectedCardCategory is 1 (cards for trade), then hide language dropdown by setting useStateStoreWrapper.setShowLanguageDropdown inside cardcategory OnChange

 

##  #reactError Maximum update depth exceeded.


```
Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops.
```
Solution - set it once (inside an onChange or onClick)



## Card Category Drop down

In mantine in the default value is a string as seen in the documentation and however whenever I try and select the value 0 on the table it just returns null and I have no idea why this is doing that and so I am now looking into it

I realise that if I remove the value prop then it works properly the only problem is that there's no default value at start and at mount of the object What I can try is to find if there's a prop for on mount and to set the value automatically otherwise I will not spend more time on it

currently I have no control on the Youtube default controls inside the video So if I press pause it doesn't pause if I put mute audio it doesn't mute the audio So I'd like the user to be able to control those video controls