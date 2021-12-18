Readme for SCREEN$ 1.9e
-----------------------

(C) 2009 By Paul Dunn.
SCREEN$ is covered by the Gnu Public License v3. See the file 'Copying' for details.

For information about porting Screen$ to the OS of your choice, please see the "Porting.txt" file that accompanies this text in the "Source" folder.



SCREEN$ is a screensaver for computers running the Windows (98/2k/XP/Vista) operating system.

It simulates the Sinclair Spectrum's screen loading process, a system that had possibly the most unique method of loading screen images in the history of computing. The screensaver simulates an automated programmer who sets up small programs to load screens, and then simulates the loading process itself.

Accuracy is important, and although previous versions of SCREEN$ were so accurate that people could hear the sound of the loading process in their heads whilst the display was running, this version is even more accurate, using timings from real Spectrums and emulators.

SCREEN$ can be configured to use very little resources at its most basic display, through to very much enhanced visuals that may tax your CPU/GPU to the limit in some cases. It is recommended that you have a reasonably advanced graphics card with Direct3D acceleration in order to get the most out of SCREEN$.



Installation
------------

Simply copy the files that accompany this text into your Windows\System32 folder. You need a "scr" folder and the screensaver itself, Screen$.scr.

An example would be this structure:

C:\Windows\System32\Scr\
C:\Windows\System32\Screen$.scr

Then from your control panel, select display properties (Personalisation options under Vista) - from there you can select the SCREEN$ screensaver and configure it to your taste.

The \Scr\ folder contains Spectrum screen images. All of which must have the ".scr" file extension, and be 6912 bytes in length. A small selection has been provided with the screensaver.



Configuration
-------------

In general, most of the options in the Configuration dialog are self-explanatory but some may need more information provided about their use.

The dialog contains a number of tabs. These are:

Hardware: Here you can choose which Spectrum to simulate, and how to handle hard-resets (if at all). You can also choose to simulate older tape-decks with hiss and wobble, though these do increase the chances of an "R Tape loading error" occurring if you have chuntey enabled.

Automation: This tab gives you options which govern how the screens are loaded. Constant LOADing just cycles through screens in a loading sequence, without resorting to BASIC programs to load them. 128k Spectrums have a few options for jumping into 48k mode, and if you want this to be used, you can set it here. You can also set a pause after loading each screen - which gives you time to appreciate the art...

Interaction: Here you can set options about how the user can interact with the screensaver. Mouse movements may disrupt the Chuntey (cause a simulated loading error), or quit the screensaver. You can elect to have chuntey disruptions occur at random - see the earlier notes on old tape-decks about how this is affected by them. You can also elect to quit the screensaver gracefully by BREAKing the loading process before it exits.

Screens: Basically just lets you specify where the screensaver finds its screens, and has options for re-arranging screen data for enhancing loading speed (which, when enabled, causes the sound produced to be slightly higher pitched) and for allowing long filenames which, while not exactly authentic, do allow you to see which screen is being loaded without the name being truncated to 10 characters. Purists will want to disable this option.

Display: From this tab, you can set the graphical preferences. The Rendering API is important, and you should choose Direct3D if at all possible, as all effects are rendered by your display hardware. DirectDraw is a fall-back system that is not as capable, and requires more CPU time than Direct3D. In particular, you should be aware that Bilinear artifact reduction and scanlines can cause enormous speed-hits under DirectDraw. GDI mode is meant for debugging, and is not recommended. 

You can set the screen resolution - bear in mind that higher resolutions mean slower performance on older hardware. 

There are options to improve the display. Reducing Bilinear filtering artifacts will reduce the amount of Blurring around pixels in the direct3d and directdraw modes, whilst avoiding the very ugly scaling provided by GDI. Rounded Display corners simulate a TV screen by rounding off the corners of the display. Scanlines darken every other line of the display, by a user-defined amount. Because Directdraw cannot perform alpha blending with hardware assistance, this option can reduce performance in Directdraw significantly. Direct3D does provide hardware acceleration for alpha blending, so will be significantly faster.

The border size may be important for users with 4:3 screens - 352x296 does not scale particularly well (especially in GDI mode), and so setting the 4:3 option here may improve scaling appearance.

Finally you can set the Aspect ratio of the display. Because a lot of modern monitors are widescreen in format, and the Spectrum display is 4:3 PAL standard, the display can look quite ugly when stretched to fit the screen. To this end, you can elect to maintain aspect ratio (with black bars to the left and right of the image) and crop to maintain aspect (which cuts off the top and bottom of the display in order to fit the display).

Sound: Here you can set options for the sound - some people like the retro-experience of hearing a Spectrum loading, but others believe that screensavers should be silent. You can choose to enable sound, and also set the volume. Beware that SCREEN$ at full volume may be very loud indeed.



WHAT TO DO IF YOU HAVE PROBLEMS!
--------------------------------

There are two problems you're likely to encounter when running SCREEN$. 

1. Performance.

This is likely due to older hardware - SCREEN$ needs quite a lot of graphics RAM to run with the enhanced effects turned on, and if your hardware is not up to the job then you're either going to end up with very poor performance, or no display at all. In the event that you find yourself with this problem, then the solution firstly is to set SCREEN$ back to it's lowest settings - 

DirectDraw mode, 640x480x16 resolution, no scanlines, no rounded display corners and no bilinear filtering reduction. This should run satisfactorily on most older hardware, assuming that your hardware is actually compatible.

2. Crashes.

This is generally, like the performance issues, due to incompatible hardware. There are two things you can try, in order:

 i) select GDI mode in the display options, and turn sound off. This uses no hardware assistance at all, and should work. If you do get a working (albeit ugly and slow) display, then go to the next step:

ii) Enable logging. By opening a command line window (Start->Run->"cmd"), start your screensaver using the /l switch. The command line, for example, might be:

C:\Windows\System32\SCREEN$.scr /l

This will enable logging - let it crash/lockup, and terminate (use task manager if necessary). When you get back to your desktop, look in the root of the drive you installed on (in this case, "C:"). There should be a file "SCREEN$.log", which you should send, along with a description of your problem - including your hardware specification and information about yout windows version - to the email address below. Logging won't fix your problem, but it will help me to get it fixed if possible.



Known Bugs
----------

SCREEN$ 1.9e is a completely rewritten version of Screen$, and as such will contain errors (bugs). There are a couple of these issues currently under investigation. 

You might, under Direct3D mode especially, experience colour corruption. This may manifest on Geforce 6 series cards.

If you find that this is the case, then please get in touch with the author at:

paul.dunn@gmail.com

And please detail exactly what was going on, what went wrong and what your hardware specs/windows/directx versions are.


