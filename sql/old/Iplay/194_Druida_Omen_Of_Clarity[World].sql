-- Druida: Fix spell Omen of Clarity, ahora solo se accionará la spell al causar daño o sanación.
UPDATE `spell_proc_event` SET `procEx`=262144 WHERE `entry`=16864;
