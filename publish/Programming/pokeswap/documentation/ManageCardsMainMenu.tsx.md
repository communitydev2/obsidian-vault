
## Component Names and functionality

- Add Cards Menu - ![[Pasted image 20260307083050.png|138]]
- 




## TCG Dropdown (Mantine Select with fetch value  ) #reactLearning 

- for this specific example I am fetching information for the ID and username of each account so I can then display it on a dropdown 
- this is being done on a useEffect And what does that mean it means that essentially I have to fetch the value and when I fetch the value I can't call on the use state yet 
- It means also that then I have to set all of the necessary use states for the dropdown at the same time that I'm setting all the other ones 
- if I'm setting anything on usestate where I'm fetching the data I also need to set all the necessary use states on the use effect for my dropdown

```

  useEffect(() => {

      async function getTcgAccounts() {

        setLoading(true)

        const user  = useAuthStoreWrapper.user?.user_id

        // console.log(session)

  

        const { data, error } = await supabase

          .from('player_tcg_account')

          .select("*")

          .eq('user_id',user)

  

  

        // let { data, error } = await supabase

        //   .from('user_account')

        //   .select(`username`)

        //   .eq('user_id', user.id)

        //   .single()

  

        if (error) {

          console.warn(error)

        } else if (data) {

          // console.log(data.map((v,i,a)=> `${v.tcg_id_username} | ${v.tcg_id}`))

          setHasTcgAccounts(data.length>0);

          setTcgAccounts(data);

          setComboData_accountUsernames(data.map((v,i,a)=> `${v.tcg_id_username} | ${v.tcg_id}`))

          setSelectedTcgAccount(data.map((v,i,a)=> `${v.tcg_id_username} | ${v.tcg_id}`)[0])



          // setUsername(data[0])

        }

  

        setLoading(false)

      }

        getTcgAccounts()

  

    }, [])




function TcgAccountDropdown() {


  

  return (

    <Select

      label={useLocStore.localizationArray[1]}

      placeholder={useLocStore.localizationArray[2]}

      data={comboData_accountUsernames}

      value={selectedTcgAccount}

      onChange={setSelectedTcgAccount}

    />

  );

}


```

## LanguageDropdown (just pre set values) #reactLearning 



- if selectedCardCategory is 1 (cards for trade), then hide language dropdown by setting useStateStoreWrapper.setShowLanguageDropdown inside cardcategory OnChange

- in the end the solution I managed to find was to set the category options to an object and attribute different arrays onto 
- it It's important to understand that mantine only takes in string values for the drop downs and therefore if you try and do anything else it will just throw an error 
- the way I found it to work was to create a use state with the default value already input onto it through using combo box and then setting that value inside its grouping operator and also adding the default value on select as the default vallue which then will set that up if you try and set the use state to null it will not work that way.
```
  const [cardCategoryOptions,setCardCategoryOptions] = useState(

    [

      {value:useLocStore.localizationArray[3]},

    {value:useLocStore.localizationArray[4]}

  ]

    

  )

  const [selectedCardCategory,setSelectedCardCategory] = useState<ComboboxItem | null>(cardCategoryOptions[0].value);


```


after some more research I've come to find having names very similar from options alright variable to the selected options a variable can throw errors of confusion while you're setting the wrong variable and so it's probably best to start the variables with option_selection_ or comboData_

the other thing I need to say as well is that unchange adding a function that that's called H whether it has const or function it doesn't matter as it simply does not work and umm turns the dropdowns to be glitchy I found that having the codes for those functions inside onChange is which is the best way forward Yeah

```
function CardCategoryDropdown() {

  

    return (

      <Select

        label={useLocStore.localizationArray[5]}

        placeholder={useLocStore.localizationArray[2]}

        data={cardCategoryOptions}

        defaultValue={cardCategoryOptions[0].value}

        value={selectedCardCategory ? selectedCardCategory.value : null}

        onChange={(_value,option)=> {

          

           setSelectedCardCategory(option)

console.log(option)



if(option.value == cardCategoryOptions[1].value){


 useStateStoreWrapper.setShowLanguageDropdown(true);


 }



        }}

      />

    );

  }


```
 

##  #reactError Maximum update depth exceeded.


```
Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops.
```
Solution - set it once (inside an onChange or onClick)





