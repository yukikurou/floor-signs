-- local function config(name)
--     return settings.startup['yuku:flsi-'..name].value
-- end

local function sprite(name)
    return '__yuku-floor-signs__/sprite/'..name
end

-- local function sound(name)
--     return '__yuku-floor-signs__/sound/'..name
-- end

local function tag(name)
    return 'yuku:flsi-'..name
end

-- Категория "Декорации" в основном меню крафта
if not data.raw['item-group']['decorations'] then
    data:extend(
        {
            {
                type = 'item-group',
                name = 'decorations',
                order = 'z',
    
                icon = sprite 'iron-ru-a.png',
                icon_size = 128,
            },
        }
    )
end

-- Подкатегория "Железные русские знаки"
data:extend(
    {
        {
            type = 'item-subgroup',
            name = tag 'iron-ru-signs',
            order = 'a',

            group = 'decorations',
        },
    }
)

-- Код знака - код сортировки
local ru_signs = {
    ['ru-a'] = '01',
    ['ru-b'] = '02',
    ['ru-v'] = '03',
    ['ru-g'] = '04',
    ['ru-d'] = '05',
    ['ru-e'] = '06',
    ['ru-yo'] = '07',
    ['ru-j'] = '08',
    ['ru-z'] = '09',
    ['ru-i'] = '10',
    ['ru-k'] = '11',
    ['ru-l'] = '12',
    ['ru-m'] = '13',
    ['ru-n'] = '14',
    ['ru-o'] = '15',
    ['ru-p'] = '16',
    ['ru-r'] = '17',
    ['ru-s'] = '18',
    ['ru-t'] = '19',
    ['ru-u'] = '20',
    ['ru-f'] = '21',
    ['ru-h'] = '22',
    ['ru-c'] = '23',
    ['ru-ch'] = '24',
    ['ru-sh'] = '25',
    ['ru-sch'] = '26',
    ['ru-hs'] = '27',
    ['ru-yi'] = '28',
    ['ru-ss'] = '29',
    ['ru-ye'] = '30',
    ['ru-yu'] = '31',
    ['ru-ya'] = '32',
}

-- Железные плиты 
for sign_name, sign_order in pairs(ru_signs) do

    local material = 'iron'

    local itm = {
        type = 'item',
        name = tag(material..'-'..sign_name..'-sign-item'),
        order = sign_order,
        
        icon = sprite(material..'-'..sign_name..'.png'),
        icon_size = 128,
        
        stack_size = 100,
        place_result = tag(material..'-'..sign_name..'-sign-entity'),
        subgroup = tag(material..'-ru-signs'),

        localised_name = { "item-name.floor-sign", { "floor-signs."..material }, {"floor-signs."..sign_name} },
    }

    data:extend({itm})

    local ent = {
        type = 'simple-entity',
        name = tag(material..'-'..sign_name..'-sign-entity'),
        
        icon = sprite(material..'-'..sign_name..'.png'),
        icon_size = 128,
        flags = {'placeable-neutral', 'player-creation'},
        subgroup = tag(material..'-ru-signs'),
        render_layer = "lower-object-above-shadow",
        selection_box = {{-1, -1}, {1, 1}},
        collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
        collision_mask = {"floor-layer"}, 
    
        minable = {
            mining_time = 0.5,
            result = tag(material..'-'..sign_name..'-sign-item'),
        },
        fast_replaceable_group = tag 'signs',
        placeable_by = {item = tag(material..'-'..sign_name..'-sign-item'), count = 1},
        max_health = 10,
        corpse = 'small-remnants',
        picture = {
            filename = sprite(material..'-'..sign_name..'.png'),
            width = 128,
            height = 128,
            scale = 0.5,
        },
        
        localised_name = { "item-name.floor-sign", { "floor-signs."..material }, {"floor-signs."..sign_name} },
    }

    data:extend({ent})

    local rcp = {
        type = 'recipe',
        name = tag(material..'-'..sign_name..'-sign-recipe'),
    
        normal = {
            enabled = true,
    
            ingredients = {
                {'iron-plate', 5},
            },
    
            result = tag(material..'-'..sign_name..'-sign-item'),
    
            energy_required = 1,
        },
        
        localised_name = { "item-name.floor-sign", { "floor-signs."..material }, {"floor-signs."..sign_name} },
    }

    data:extend({rcp})
end