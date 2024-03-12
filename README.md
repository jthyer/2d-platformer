# 2d-platformer
Basic extensible 2d platformer engine in Love2D and Ogmo.

Done:
- Loading tiles and objects via Ogmo, drawing them to screen.
- Loading multiple scenes.
- Handling object logic via closures.
- Complex player movement with variable jumping.
- Simple sprite animation for any visible objects.

Player To-Do:
- Player still bounces on the ground sometimes. Replace rounding with actual "move to contact" function?
- Put legs down when fast falling.
- Spin shouldn't change direction mid-jump.
- Spin shouldn't change to fall until end of animation.
- Player should be able to die.

Misc. To-Do:
- Replace L and R sprite sheets with simple reflection.
- Spikes. Player should be able to hit spikes and enemies and die.
- Implement remaining jellyfish and bullets.
- Very simple title screen, move between three stages, very simple ending. Do the title in-engine, like Game Maker.
- Can still clip into corners. Do looping collision check to make sure player doesn't get stuck?
- Am I feeling ambitous? Let's set up some moving pass-through platforms.