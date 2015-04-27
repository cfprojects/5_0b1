The ColdSpring Framework 1.2, which runs on ColdFusion 7.0 and higher must be installed in your webroot or with a mapping for Gliint to operate.
While Gliint is expected to perform on other CF engines like Railo and openBlueDragon it has NOT yet been tested against them.
Quickstart:
1. Copy this distribution to your web root, which must NOT contain directories named: config, controller, docs, model, org, samples, view
	and must NOT contain files named Application.cfc and index.cfm. 
	
	If you've pulled this down from subversion, you can use the ant-copy.xml task with Eclipse.
	CAUTION: It will ask you for the source and destination directories, and will overwrite everything in the destination directory.

2. Type the url to your webroot into your browser - you should see the Hello page.
3. Read the docs.