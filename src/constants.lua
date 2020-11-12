-- Debug mode
DEBUG = false

-- Keyboard controls
CONTROLS = {
    up={'up', 'z', 'w'},
    left={'left', 'a', 'q'},
    down={'down', 's'},
    right={'right', 'd'},
    play={'a', 'b', 'space'}
}

-- Game size
WIN_WIDTH = 400
WIN_HEIGHT = 240

-- Play zone
WIDTH = 400
HEIGHT = 180

-- Player speed
XY_SPEED = 500
XY_MIN_SPEED = 10 -- when the arm is outstretched
Z_SPEED = 10

-- Glass fragility
SPEED_HISTORIC_INTERVAL = 0.1 -- over which duration the speed is calculated
DANGEROUS_SPEED = 5 -- At which speed the glass broke

-- Targets spawn
MIN_SPAWN_INTERVAL = 5 -- at the beginning
MAX_SPAWN_INTERVAL = 1/Z_SPEED + 1/Z_SPEED + WIDTH/XY_SPEED -- hardest (1)
FIRST_SPAWN_INTERVAL = 1 -- when there is no targets
MAX_SCORE_LEVEL = 300 -- The score at which the game becomes the most difficult 

-- Game over condition
MAX_TARGETS = 4
MAX_CRACKS = 3

-- Game over types (code)
GAMEOVER_TOOMANY, GAMEOVER_BROKEN = 1, 2

-- Size of glasses
GLASS_WIDTH = 50
GLASS_HEIGHT = 50

-- Movement of the targers
TARGET_NOISE_AMP = 20

-- Sprites and animation 
PLAYER_SPRITES_NUMBER = 18
PLAYER_SPRITES_CENTER = {y=25}
TARGETS_SPRITES_NUMBER = 1
TARGETS_SPRITES_CENTER = {x=124,y=25}
PARTY_SPRITES_NUMBER = 4
TCHINING_SPRITE_DURATION = 0.2

-- Colors
WHITE = {r=177,g=174,b=168}
BLACK = {r=50,g=47,b=41}


-- Text
TEXT_TITLESCREEN = [[Welcome to the party !

Don't forget that not to toast with someone who wants to toast with you is frowned upon.
Also, the glasses are made of glass, so be careful.

Use the arrows and the crank to move the glass.
Press A or B to start.

Game: Léon Lenclos
Music: Louis Pezet
]]
TEXT_GAMEOVER = {
    "Oops, the guests are offended that you don't want to toast with them...\n\nSCORE: ",
    "Oops, you broke your glass...\n\nSCORE: ",
}