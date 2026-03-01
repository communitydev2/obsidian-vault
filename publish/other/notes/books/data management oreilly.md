
 
## Operations teams are vital to keeping a software system running smoothly.
 - A good operations team typically is responsible for the following, and more [29]:
- Monitoring the health of the system and quickly restoring service if it goes into a bad state 
- Tracking down the cause of problems, such as system failures or degraded performance
- Keeping software and platforms up to date, including security patches
- Keeping tabs on how different systems affect each other, so that a problematic change can be avoided before it causes damage 
Anticipating future problems and solving them before they occur (e.g., capacity planning) 
• Establishing good practices and tools for deployment, configuration management, and more 
• Performing complex maintenance tasks, such as moving an application from one platform to another
• Maintaining the security of the system as configuration changes are made
• Defining processes that make operations predictable and help keep the production environment stable
• Preserving the organization’s knowledge about the system, even as individual people come and go 


## Data systems can do various things to make routine tasks easy, including: 
• Providing visibility into the runtime behavior and internals of the system, with good monitoring
• Providing good support for automation and integration with standard tools
• Avoiding dependency on individual machines (allowing machines to be taken down for maintenance while the system as a whole continues running uninterrupted) 
• Providing good documentation and an easy-to-understand operational model (“If I do X, Y will happen”)
• Providing good default behavior, but also giving administrators the freedom to override defaults when needed
• Self-healing where appropriate, but also giving administrators manual control over the system state when needed
• Exhibiting predictable behavior, minimizing surprises


## requirements for an application 

An application has to meet various requirements in order to be useful. There are functional requirements (what it should do, such as allowing data to be stored, retrieved, searched, and processed in various ways), and some nonfunctional requirements (general properties like security, reliability, compliance, scalability, compatibility, and maintainability). 
In this chapter we discussed reliability, scalability, and maintainability in detail. 

- Reliability means making systems work correctly, even when faults occur. Faults can be in hardware (typically random and uncorrelated), software (bugs are typically systematic and hard to deal with), and humans (who inevitably make mistakes from time to time). Fault-tolerance techniques can hide certain types of faults from the end user.
- Scalability means having strategies for keeping performance good, even when load increases. In order to discuss scalability, we first need ways of describing load and performance quantitatively. We briefly looked at Twitter’s home timelines as an example of describing load, and response time percentiles as a way of measuring per formance. In a scalable system, you can add processing capacity in order to remain reliable under high load.
- Maintainability has many facets, but in essence it’s about making life better for the engineering and operations teams who need to work with the system. Good abstractions can help reduce complexity and make the system easier to modify and adapt for new use cases. Good operability means having good visibility into the system’s health, and having effective ways of managing it. 
- There is unfortunately no easy fix for making applications reliable, scalable, or maintainable. However, there are certain patterns and techniques that keep reappearing in different kinds of applications. In the next few chapters we will take a look at some examples of data systems and analyze how they work toward those goals.

## For example: 
1. As an application developer, you look at the real world (in which there are people, organizations, goods, actions, money flows, sensors, etc.) and model it in terms of objects or data structures, and APIs that manipulate those data structures. Those structures are often specific to your application. 
2. When you want to store those data structures, you express them in terms of a general-purpose data model, such as JSON or XML documents, tables in a relational database, or a graph model. 3. The engineers who built your database software decided on a way of representing that JSON/XML/relational/graph data in terms of bytes in memory, on disk, or on a network. The representation may allow the data to be queried, searched, manipulated, and processed in various ways. 4. On yet lower levels, hardware engineers have figured out how to represent bytes in terms of electrical currents, pulses of light, magnetic fields, and more. In a complex application there may be more intermediary levels, such as APIs built upon APIs, but the basic idea is still the same: each layer hides the complexity of the layers below it by providing a clean data model. These abstractions allow different 