#   31:08
https://www.youtube.com/watch?v=qlYhdO11EfQ
```
 npx create-video@latest
npm install
I selected hello world project
```

shift - R brings the render menu where you can change any text you need

Each component in root.tsx is a video track in the timeline

On the default project, rendering the vidoe on a higher res meant that the logo got distorted as it had hardcoded values on sizes

To start , add a composition to root.tsx, with custom id and component name


### make basic animation

```
const rectOffset = frame * 10;

return
<AbsoluteFill
style={{
justifyContent: "center",
alignItems: "center",
fontSize: 100,
backgroundColor: "white",
}}

<p>The current frame is {frame} .< /p>
<div
className="bg-red-500 size-30 mt-8"
style={{ transform: `translateX(${rect0ffset}px)' }}
/>
</AbsoluteFill>

}



```