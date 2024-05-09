# Contributing to ZekDex

First off, thank you for considering contributing to ZekDex. It's people like 
you that make ZekDex such a great tool.

## Where do I go from here?

If you've noticed a bug or have a feature request, make the first move by 
creating an issue in the GitHub issue tracker. This is a good way to communicate 
your ideas and collaborate with the community.

## Contributing to Art

ZekDex welcomes contributions to improve the visual aspects of the project. 
Whether it's designing logos, creating graphics for documentation, your
contributions are greatly appreciated. When contributing art, please
consider the following:

- **Relevance**: Ensure that your contributions are relevant to ZekDex and enhance 
the user experience or understanding of the project.
- **Originality**: All art contributions should be original work or used with 
permission and properly attributed.
- **Quality**: Maintain a high standard of quality for all art contributions. 
Images should be clear and legible.

## Contributing to Documentation

Good documentation is crucial to the success of ZekDex. Whether it's updating 
existing documentation or creating new content, your contributions can make a 
big difference. When contributing to documentation, please consider the following:

- **Accuracy**: Ensure that your contributions are accurate and up-to-date with 
the current state of ZekDex.
- **Clarity**: Documentation should be clear and easy to understand. Avoid 
jargon and explain complex concepts as simply as possible.
- **Comprehensiveness**: Try to cover all aspects of the topic you are documenting. 
Don't leave out important details.
- **Reduction of Redundancy**: To maintain consistency and avoid redundancy, 
avoid having copies of text in multiple locations. Instead, use code to modify 
one format to the other. For example, if a piece of information is relevant in 
multiple places, consider creating a single source of truth and referencing it 
as needed.
- **README**: The README is generated from `README_SRC.md` and should not be 
edited directly. Any changes to the README should be made in `README_SRC.md`.

## Using GitHub Desktop

If you prefer using a graphical user interface, you can make use of GitHub Desktop. 
Here are the steps:

1. **Clone the Repository**: After installing GitHub Desktop and signing in with 
your GitHub account, click on `File > Clone Repository`. Choose the repository 
you want to clone and the local path on your computer where you want the 
repository files to be saved.

2. **Create a Branch**: Click on `Branch > New Branch`, enter a name for your 
branch, and click `Create Branch`. A good branch name would be (where issue #325 
is the ticket you're working on): `feature/325-add-rayquaza-data`.

3. **Make Changes**: Navigate to the local path of the repository on your computer 
and make changes to the files as needed.

4. **Commit Changes**: After making changes, go back to GitHub Desktop. You will 
see the changes you made listed. Enter a commit message describing your changes, 
and click `Commit to <branch>`.

5. **Push Changes**: After committing your changes, click `Push origin` to push 
your committed changes to the remote repository on GitHub.

6. **Create a Pull Request**: Go to GitHub and navigate to the repository. Click 
on `New pull request` and select your branch to create a new pull request.

7. **Rebase your Branch**: If a maintainer asks you to "rebase" your PR, they're 
saying that a lot of code has changed, and that you need to update your branch 
so it's easier to merge. In GitHub Desktop, you can do this by clicking 
`Branch > Rebase Current Branch`. Then, force push your changes to update your 
branch on GitHub.

## Using Command Line Interface (CLI)

If you are comfortable with using command-line tools, here are the steps:

1. **Clone the Repository**: After installing Git and signing in with your GitHub 
account, run `git clone <repository-url>`. Replace `<repository-url>` with the 
URL of the repository you want to clone.

2. **Create a Branch**: Run `git checkout -b <branch-name>`. Replace `<branch-name>` 
with a descriptive name for your branch. A good branch name would be (where issue #325
is the ticket you're working on): `feature/325-add-rayquaza-data`.

3. **Make Changes**: Navigate to the local path of the repository on your computer 
and make changes to the files as needed.

4. **Commit Changes**: After making changes, run `git add .` to stage your changes 
and `git commit -m "<commit-message>"` to commit your changes. Replace 
`<commit-message>` with a description of your changes.

5. **Push Changes**: After committing your changes, run `git push origin <branch-name>` 
to push your committed changes to the remote repository on GitHub.

6. **Create a Pull Request**: Go to GitHub and navigate to the repository. Click 
on `New pull request` and select your branch to create a new pull request.

7. **Rebase your Branch**: If a maintainer asks you to "rebase" your PR, they're 
saying that a lot of code has changed, and that you need to update your branch 
so it's easier to merge. Run `git pull --rebase origin master` and then 
`git push --force-with-lease origin <branch-name>` to update your branch on GitHub.

## Merging a PR (maintainers only)

A PR can only be merged into master by a maintainer if:

- It is passing CI.
- It has been approved by at least one maintainer. If it was a maintainer who 
opened the PR, only another maintainer can approve it.

## Thank you!

Your contributions to open source, large or small, make great projects like this 
possible. Thank you for taking the time to contribute.

```
 - ZekromVale                                  .;::::;,''lxkkxxxdoolc:;,'.                                                                            
                                                ,:;::;,'.'lkkxxxdool:;;''.                                                                            
                                                .;;;;:;,..'okxxxdolc:;,''.                                                                            
                           ..,,,;,,''....     .'::;;;;:;...:xxxddolc:;,'..                                                                            
                            ..';::ccllllcclcccoxdc;;;;::,..cxxxdoolc:;,'..                                                                            
                                   ....;loxddooolc;,,;clc;,cxxddoolc:;,'..                                                                            
                                      .lxdoooooooodl;;ldddc:oxddoolc;,'...,c:,..                                                                      
                                      ;olooooddddxOKkccdxxdool:;;;;;,'...'kXXK0Oxoc;,..                                                               
                                     .clclloooodddOK0dcoxkkxdc,.'''''''..,okkkO00KKXXKOxdolcc:;,'.                                                    
                                     .::clloooddkO0OkxodxkkOkdl;,''''.....,:loddxxkkOO00KKKKXXXXKOxoc,.                                               
                                      ';:cllldOKXKOkxxddxkOOOkdoc,''''......'cooooooddxxkkkkOOOO00000Oxc.                                             
                                      .';:ccdKNK0kxxxxdxxkkOOOxdoc,''........'cllllllooooddddxxxkkkkOOOko;'.                                          
                                       .';cxKX0OkxdddddxxxkOOOkxdoc;'.........;lclllllloooooooooddddxxxxxxxoc'                                        
                                         ,xKKOkxxddddddxxxkkOOOkxdol:'........,ccccccllllllooollllooooddddddol:.                                      
                                        'xK0kxddddooooodxxxkkOOOkxdllc,...    ':cccccccccllllllllllllllloooodol;.                                     
                                       :O0OkddoooollllloxxdxkkOOkxdollc:'.    .;:::ccccccccccccccccccllllllllool:..                                   
                                     .lOkxddollllcccc::lxxdxxkOOkkxdolccc;.   ..,,;;::::cccccccccccccccccccccccclc:'                                  
                                     ;kxoollcc::;;;;;;;cxxddxxkkkkxdolcccc:,'....   .....'',,;;;;:::::::::ccccc:::::.                                 
                                    .cl:::;,,,,;;::ccccoxxddxxxxo:,,''',:cccc:;'..         .  ...........'',,;;::;;;,.                                
                                  .'cdoollccccclloolllloxxddddc,.....'...;:c::cc:;'.         .,'.   .'.      ....'',,'.                               
                              .,codxddooooooooooodxdooodxxdddo,.'''''''...',;;:::cc:;'.      .,.. .;:'.         .....'.                               
         ...',;;,'..      .,:lxOOxxdooooooooodddddxkxxxxxxdodl'.',,,,,''.....';::::::cc'     ..  .;,.            .......                              
.;clodxxkO0KKXNXX0Okdoc:,;x0kdlcccccclloodddddddxxxxxxxxxdooo:..'',,,,'''......';:::::::'                         .......                             
XWWNXKK0Okkkxxxxdooolllcco0Kkdolcc:::::::cclooodddxxxxxxddool;..'',,,,'''.........',;;;;;.                          ......                            
XK0Okxxdddolccccc::::::;;l00xdooooooooollcc::cccccccokxddoolc,..'',,,,''''...........,,;,,.                          ......                           
kkxxxddolcccccccc:::;;;;,lkxolllloodddddddddooooollldxxdoool:'..'''',,''''.............'''..                           .....                          
xxddolcccccc::;;;,,,,''''cxoccllllooooddddddddddddxkkxdoooll,...''''''''''............. ..'.                            .....                         
oolcccccc:;;,,'..........cocccccllloooooooooddddddxkxddolll;.....'''''''''..................                              ....                        
cccccc:;;,''........'',;:cc::cccccllllllllooooooooddddolll:......'''''''''..'..........  ...                               ....                       
lc::;;,'......';codxkkO0d;,,;:::cccclllllllllooolllllolllc,......''''''''''''........... ...                                ....                      
:;,,''.....';lxOKXXXXXXOl,'.''',;:cccccccclccccccc:;:cccc;.........'''''''''''.......... ...                                  .                       
;,'.....,:ok0KXXXNNNNNKdc:;;;;,'';::::::cc::::;;;;;'';:::'.........'''''''''''..........  ..                                                          
'....':dk0XXNNNWWWWWNKxlcc::cc:;,',;;;;;::;;,,,,,,,'..';;;.........'''''''''''.'........  ..                                                          
....;d0XXNNNNWWNNNNNXkocccccclcc:,'',,,,,,'''.....'.....';;'........''''''''''''........  ..                                                          
 .'lkKXNNWWNNNNNNNNXOdlcclllllllc:,..''''.................,,'.......'''''''''',,'.......  ...                                                         
.:x0XXNNWNNNNNNWWWX0xollllloollllc:,..................... .','.......'''''''',;:;,......   .,'  .                                                     
dOKKKXXNNNNWWWWNNNKkdolooooooollllc:;.......         ..... ..',.........'...',;:;,'......   ,c. .                                                     
KXKKKKKKXNNNNNNNNN0xooooooooooollllc;.......             ... ..,'..........'',,;;,'.....    :l.                                                       
NNXXKKKKKXXNNNNNXkxdooddddddoooolll:.............           .  .''........'''',,,,'.....    cl.                                                       
WWNXXXKKKKKXXNNKo:ddlooodddoooooll:..............              .,''..........''''''.....    ,:...                                                     
WNNNNNXXKKKKKKKKl;ooloooddoooooolc'...............        ...  .:c,............''''.....    .....                                                     
KXXNWNNNNXXKKK0Oo:olllloooooooolc,.................        ......,cc. ............'.....      ..                                                      
dxxkkO0KKKKKK0Oko:llcclooooooool;.........'..''......       ..... .;c;. ................     ...                                                      
xxxxddxxxxxxxxdo:;:cccllooooolll;..'''',:loc:c:;;,''.....    ........;;.................      .                                                       
xxxxxxkkkkkkkxol:::::cclodxkkOOOxddoc;,;;;,'.............      .......'..  ..  .........                                                              
ooddddddddddxdoc:;;coxk00K00kdl:'..........                      ..........     ........       ...                                                    
Okxxddoolcc:ldddxO00K0Oxoc;'...                                     .........      .....       ..''.                                                  
WWNNXXK0OOkxOKKK0kdl;,...                                              .......      ....       ....''.                                                
WNNNNWWWNXK0kdc;'...                                                     ......               ......',.                                               
WWWNNKOxoc;'...                                                                .             .........''.                                             
X0kdl;'...                                                                                   ...........''.                                           
:,...                                                                                       ..............'.                                          
                                            .,,..         ...                               ................'.                                        
                                           .:lc:;,..  .........                            ............'''...'..                                      
                                          ':c::;,'.....'''''''...                           ..........'''......'.                                     
                                        .,c:;;;,,'....,,;;;;;,,'.                            ..........'.''''......                                   
                                       .,::;;,,''....':::::::;,'..                            ...........''''''.....                                  
                                      .,;,,,''......'clcccc:::;,'..                            ..........'''''''.....                                 
                                      ...........  .:lllccc:::;;,..                             ..........'''''''.....                                
                                         ......   .;llllccc::::;,'..                             ..........''''''''....                               
                                                 .,lllllcccc::::;,'..                        ..   ..........'''''''''...                              
                                               .':lllllcccccc::::;,'..                      .....  ...........'''''''''..                             
                                             .':cllllllcccccc::::;;,'..                     .......  ..........''''''''...                            
                                            .;::ccccccccccccc::::;;,,'..                  ..........  ...........'''''.....                           
                      ...''..               .;;;::ccccccccccc:::::;;,,'.                  ...........  ...........''''.....                           
                ..,;::cc:;;,'..              .',;::::ccccc::::::::;;;,,'.        ...     .............  ..................                            
           .';coddddoolc:;,''.. ......        ..,;;::::::::::::::::::;,'.        .xko:.  ...............  ..............                              
       .,:ldkkxxxdoollc:;;,'.. ......           .',;;;;;;:::::::::::::;'          ,dxoc'.................  ...........                                
  ..,codkkkkkxxxddollcc:;,'..  .....             ..',,;;;:::::cc::cccc:,..........,ldlcol'................  .........                                 
.,ldxkxxxxxxxxdddollcc:;,,'.   ...                 ..,,;;;:::cccccclllllllllloddxxxkxxdk0x,...............    ......                                  
:oxxxxxxxxxddddoollcc:;,,'..                         .',,;;::ccccllodddddxxxxkkkkkkkkkkkOkdc'..............    ....                                   
ldxxdddddddooooollc::;;,'..                           ..,,;;::cclodxxxxxkkkkkkOOOOOOOOOOOOOOko:,............    .                                     
dddddoll::;,,;cllc::;;,''..                             .',,;:cllodddddxxkkkkOOOOOOOO000OOOOOO0ko:.       .                                           
oc;;,''........,:::;;,,'..   .                           .',;:cclllooddxxxkkkkkOOOOOO0000000000000xc'.                                                
,..''''''''......,;;;,''.                                 ';;:cccllooddxxxxkkkkOOOOOOO00000000000000k:.                                               
```