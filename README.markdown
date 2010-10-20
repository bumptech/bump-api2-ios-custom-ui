Bump API v2 for iOS - Custom UI
-------------------------------

Copyright (c) 2010, Bump Technologies, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of Bump Technologies, Inc. nor the names of its contributors
  may be used to endorse or promote products derived from this software without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

What is it?
-----------

This is the source code of an implementation of a custom ui for Bump API v2.x on iOS. This also happens to be the default UI that you get in the Bump API if you don't implement your own. Simply put, creating your own custom UI for the Bump API is completely optional; however, if you do choose to implement your own this code can be used as a template of a fully working UI. You can use this template to simply tweak the default implementation by adjusting the colors, fonts, images, etc. Or you can go as far as coming up with your own Bump API UI to be tightly integrated into your Application's style. We only ask that you follow some general API style guidelines that you can find here: [http://bu.mp/bumpAPIinstructions](http://bu.mp/bumpAPIinstructions#customui)

We also encourage the community to fork this repository and share your cool UIs with other Bump API developers.

How do I use it?
----------------

If you use git for source control we recommend adding this project as a submodule to your own.
More info on submodules here: [http://book.git-scm.com/5_submodules.html](http://book.git-scm.com/5_submodules.html)
This way if we make improvements to our template, you can easily merge those fixes into your customized template. Also if you find bugs in our template you can easily give back to the Bump API developer community by submitting patches to your fork and sending us a pull request.

Git isn't required though, you can also simply download a zip of the current release from the download section of bumptech's github page if you prefer.

Once you have the template locally, simply add all of the files to your xcode project and then set the custom UI as the UI for the API to use like so:

	BumpAPIUI *myUi = [[BumpAPIUI alloc] init];
	[myUi setParentView:self.view];
	[myUi setBumpAPIObject:[BumpAPI sharedInstance]];
	[[BumpAPI sharedInstance] configUIDelegate:myUi];

Once you have all of that working you can customize the UI code to suit your needs.

The `<BumpAPICustomUI>` Protocol
--------------------------------

This default Bump API UI (the source in this repository) implements the BumpAPICustomUI protocol to communicate with the BumpAPI. The API gives you detailed callbacks via this protocol that notify you what state the API is in. This protocol is fully described in the documentation that's distributed the API.
