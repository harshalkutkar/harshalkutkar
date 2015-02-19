# harshalkutkar
Game made for Mobile Game Dev Class

Game Design Document
Harsh Alkutkar
Objective
The objective of the game is to stop the enemy characters from reaching your treasure by placing objects that destroy the enemy characters in front of it.
Gameplay Mechanics
This game mainly plays on the mini-game – progression map based
The mini-game consists of the player can select various objects, place them on the grid in front of the enemy (Grid Based). After each successful mini-game the user would unlock certain achievements and would advance in the progression map.
Level Design
Levels should be focused around the objective but by tweaking the game mechanic by increasing the difficulty level gradually and allowing different power ups at different levels.
Levels designed may tweak the following for anyone to distinguish them.
-	Time Limit to Finish
-	Movement Speed of enemies
-	Available Power Ups
-	Available items that can be placed.
-	Cooldown time for a certain item
-	Cost for a certain item.
Levels should be designed such that each level is clearly distinguished from previous levels by using factors mentioned before. Navigational cues must be given, initial levels will contain tutorials to help the user play.


Technical
Scenes
•	Main Menu (needs continue button to avoid level select when possible)
•	Level Select / Progression Map.
•	Gameplay
Controls/Input
o	Touch based input. Touch to place.
Classes/CCBs
•	Scenes
o	Main Menu
o	Level Select / Progression Map
o	Gameplay
•	Nodes/Sprites
o	Entity (abstract superclass)
•	Player
•	Enemy (Different Types)
o	WorldObject (abstract superclass)
•	Time
MVP Milestones
Week 1 (2/11 - 2/18/2014)
•	Create / Implement Sprites
•	Implement World (Minigame)
Week 2 (2/19 - 2/24/2014) - finishing a playable build
•	Implement Point System
•	Implement Enemy Approach
o	Implement Collision Physics
o	Implement Collision Animations
Week 3 (2/24 - 3/3/2014)
•	Create Levels
•	Tweak Conditions for each level
•	Create more enemy structures if needed.
Week 4 (3/3 - 3/10/2014) - finishing core gameplay
•	Incorporate Progression Map
•	Refine levels -- playtest even more often!!
•	Refine control scheme
Week 5 (3/17- 3/24/2014)
•	Testing the game holistically – progression map+game.
•	Determine what other polish is needed
Week 6 (3/24 - 3/31/2014) - finishing the polish
•	Work on rewinding particle effects
•	Integrate analytics
•	Screenshots
•	Write game description for App store
•	Play around with Apportable to see if Android release is feasible


