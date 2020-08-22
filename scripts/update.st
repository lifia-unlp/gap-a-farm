Transcript cr; show: 'Updating from the remote repository'.
(IceRepository registry detect: [ :each | each name = 'gap-a-farm' ]) pull.
Transcript cr; show: 'Update finished'; cr.

