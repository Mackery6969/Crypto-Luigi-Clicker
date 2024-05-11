package;

class ResultsState extends FlxState
{
	var resultsComingIn:FlxText;

	var canInteract:Bool = false;
	var playLoop:Bool = false;

	var intro:FlxSound;
	var resultsLoop:FlxSound;

	var results:FlxGroup;
	var resultsTitle:FlxText;
	var totalMoneyGained:FlxText;
	var totalMoneyLost:FlxText;
	var totalMoneySpent:FlxText;
	var totalLandBought:FlxText;
	var totalBuildingsBought:FlxText;
	var totalClicks:FlxText;
	var finalMoneyCount:FlxText;
	var finalMoneyPerClickCount:FlxText;
	var finalMoneyPerSecondCount:FlxText;
	var runTime:FlxText;
	var pressEnter:FlxText;

	override public function create()
	{
		PlayState.lost = true;
		PlayState.musicCanPlay = false;
		ClientPrefs.saveSettings();

		if (FlxG.sound.music != null && FlxG.sound.music.playing)
			FlxG.sound.music.stop();

		super.create();

		var bg:FlxSprite = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff0d0f49);
		bg.visible = false;
		add(bg);

		resultsComingIn = new FlxText(0, 0, FlxG.width, "Results Coming In...");
		resultsComingIn.size = 16;
		resultsComingIn.alignment = "center";
		resultsComingIn.y = FlxG.height / 2 - resultsComingIn.height / 2;
		resultsComingIn.font = Util.font("comic-sans", "bold");
		add(resultsComingIn);

		if (!ClientPrefs.secretSounds) {
			// play the intro sound
			intro = new FlxSound();
			intro.loadEmbedded(Util.music("results-intro"));
			if (!ClientPrefs.sound)
				intro.volume = 0;
			intro.play();

			// when the intro sound finishes, play the results sound
			intro.onComplete = function()
			{
				resultsComingIn.kill();
				canInteract = true;

				var drums = new FlxSound();
				drums.loadEmbedded(Util.music("results-final"));
				if (!ClientPrefs.sound)
					drums.volume = 0;
				drums.play();

				drums.onComplete = function()
				{
					playLoop = true;

					// add the results text one by one
					add(results);
					bg.visible = true;

					resultsLoop = new FlxSound();
					resultsLoop.loadEmbedded(Util.music("results-loop"));
					if (!ClientPrefs.sound)
						resultsLoop.volume = 0;
					resultsLoop.play();
				};
			};
		} else if (ClientPrefs.music) {
			FlxG.sound.playMusic(Util.music("raldi/resultsComingIn"), 0.5, true);
			FlxG.sound.music.play();

			bg.visible = true;
			resultsComingIn.kill();
			canInteract = true;
		}

		// create the results text
		results = new FlxGroup();

		resultsTitle = new FlxText(0, 0, FlxG.width, "Final Results");
		resultsTitle.size = 32;
		resultsTitle.alignment = "center";
		resultsTitle.y = 50;
		resultsTitle.font = Util.font("comic-sans", "bold");

		totalMoneyGained = new FlxText(0, 0, FlxG.width, "Total Money: $" + Std.string(ClientPrefs.totalMoneyGained));
		totalMoneyGained.size = 16;
		totalMoneyGained.x = 100;
		totalMoneyGained.y = 200;
		totalMoneyGained.font = Util.font("comic-sans");

		totalMoneyLost = new FlxText(0, 0, FlxG.width, "Total Money Lost: $" + Std.string(ClientPrefs.totalMoneyLost));
		totalMoneyLost.size = 16;
		totalMoneyLost.x = 100;
		totalMoneyLost.y = totalMoneyGained.y + totalMoneyGained.height + 10;
		totalMoneyLost.font = Util.font("comic-sans");

		totalMoneySpent = new FlxText(0, 0, FlxG.width, "Total Money Spent: $" + Std.string(ClientPrefs.totalMoneySpent));
		totalMoneySpent.size = 16;
		totalMoneySpent.x = 100;
		totalMoneySpent.y = totalMoneyLost.y + totalMoneyLost.height + 10;
		totalMoneySpent.font = Util.font("comic-sans");

		totalLandBought = new FlxText(0, 0, FlxG.width, "Total Land Owned: " + Std.string(ClientPrefs.totalLandBought) + " acres");
		totalLandBought.size = 16;
		totalLandBought.x = 100;
		totalLandBought.y = totalMoneySpent.y + totalMoneySpent.height + 10;
		totalLandBought.font = Util.font("comic-sans");

		totalBuildingsBought = new FlxText(0, 0, FlxG.width, "Total Buildings: " + Std.string(ClientPrefs.totalBuildingsBought));
		totalBuildingsBought.size = 16;
		totalBuildingsBought.x = 100;
		totalBuildingsBought.y = totalLandBought.y + totalLandBought.height + 10;
		totalBuildingsBought.font = Util.font("comic-sans");

		totalClicks = new FlxText(0, 0, FlxG.width, "Total Clicks: " + Std.string(ClientPrefs.totalClicks));
		totalClicks.size = 16;
		totalClicks.x = 100;
		totalClicks.y = totalBuildingsBought.y + totalBuildingsBought.height + 10;
		totalClicks.font = Util.font("comic-sans");

		finalMoneyCount = new FlxText(0, 0, FlxG.width, "Final Money: $" + Std.string(ClientPrefs.finalMoney));
		finalMoneyCount.size = 16;
		finalMoneyCount.x = 100;
		finalMoneyCount.y = totalClicks.y + totalClicks.height + 10;
		finalMoneyCount.font = Util.font("comic-sans", "bold"); // final counts are bold
		
		finalMoneyPerClickCount = new FlxText(0, 0, FlxG.width, "Final Money Per Click: $" + Std.string(ClientPrefs.finalMoneyPerClick));
		finalMoneyPerClickCount.size = 16;
		finalMoneyPerClickCount.x = 100;
		finalMoneyPerClickCount.y = finalMoneyCount.y + finalMoneyCount.height + 10;
		finalMoneyPerClickCount.font = Util.font("comic-sans", "bold");

		finalMoneyPerSecondCount = new FlxText(0, 0, FlxG.width, "Final Money Per Second: $" + Std.string(ClientPrefs.finalMoneyPerSecond));
		finalMoneyPerSecondCount.size = 16;
		finalMoneyPerSecondCount.x = 100;
		finalMoneyPerSecondCount.y = finalMoneyPerClickCount.y + finalMoneyPerClickCount.height + 10;
		finalMoneyPerSecondCount.font = Util.font("comic-sans", "bold");
		
		// total run time in 0:00:00 format
		var runTime = new FlxText(0, 0, FlxG.width, "Total Run Time: " + Util.formatTime(ClientPrefs.runTime));
		runTime.size = 18;
		runTime.x = 100;
		runTime.y = finalMoneyPerSecondCount.y + finalMoneyPerSecondCount.height + 10;
		runTime.font = Util.font("comic-sans", 'bold');

		pressEnter = new FlxText(0, 0, FlxG.width, "Press Enter to Play Again");
		pressEnter.size = 16;
		pressEnter.alignment = "center";
		pressEnter.y = FlxG.height - pressEnter.height - 10;
		pressEnter.font = Util.font("comic-sans");

		results.add(resultsTitle);
		results.add(totalMoneyGained);
		results.add(totalMoneyGained);
		results.add(totalMoneyLost);
		results.add(totalMoneySpent);
		results.add(totalLandBought);
		results.add(totalBuildingsBought);
		results.add(totalClicks);
		results.add(finalMoneyCount);
		results.add(finalMoneyPerClickCount);
		results.add(finalMoneyPerSecondCount);
		results.add(runTime);
		results.add(pressEnter);

		// update gamejolt highscores
		if (ClientPrefs.gameJolt) {
			GJLogin.addScore(Math.round(ClientPrefs.totalMoneyGained), 906371);
			GJLogin.addScore(Math.round(ClientPrefs.totalClicks), 907239);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		#if discord_rpc
		DiscordHandler.changePresence('Getting Final Results...', "ResultsState");
		#end

		if (canInteract)
			add(results);

		if (resultsLoop != null && !resultsLoop.playing && playLoop)
		{
			resultsLoop.play();
		}

		#if debug
		if (FlxG.keys.justPressed.F1)
		{
			PlayState.lost = false;
			PlayState.inDebt = false;
			FlxG.switchState(new PlayState());
		}
		#end

		if (canInteract)
		{
			if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
			{
				ClientPrefs.resetSettings('game');
				trace('reset save');
				FlxG.switchState(new PlayState());
			}
		}
	}
}