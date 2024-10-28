# 2d-platformer
Basic extensible 2d platformer engine in Love2D and Ogmo.

Done:
- Loading tiles and objects via Ogmo, drawing them to screen.
- Loading multiple scenes.
- Handling object logic via closures.
- Complex player movement with variable jumping.
- Simple sprite animation for any visible objects.
- Player can die.
- Player can bounce off enemies.

Player To-Do:
- Enemies should die when you bounce on them.
- Player should die when falling in pit.
- Player still bounces on the ground sometimes. Replace rounding with actual "move to contact" function? Often bounces on one frame jumps.

Misc. To-Do:
- Spikes. Player should be able to hit spikes and enemies and die.
- Implement remaining jellyfish and bullets.
- Very simple title screen, move between stages, very simple ending. Do the title in-engine, like Game Maker.
- Can still clip into corners. Do looping collision check to make sure player doesn't get stuck?
- Draw a pretty background.