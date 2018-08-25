import inspect, os, shutil

this_file = inspect.getfile( inspect.currentframe() )
this_path = os.path.abspath( this_file )
working_directory = os.path.dirname( this_path )

print('running {} ...'.format(this_file))
print('working directory : {}'.format(working_directory))

src_dir = os.path.abspath( os.path.join( working_directory, '../../src') )
cache_file = os.path.join( working_directory, 'rename_list.txt')

with open(cache_file, 'r') as f_h:
    print('    reading changes from {}'.format(cache_file))
    rename_list = f_h.read().split('\n')
    print('    renamelist:')
    print(rename_list)

for f in rename_list:
    if f.endswith('.c'):
        new_path = f.replace('.c', '.cu')
    elif f.endswith('.h'):
        new_path = f.replace('.h', '.cuh')
    else:
        raise Exception('Unknown file type {} for {}'.format('.' + f.split('.')[-1], f))
    print('    revert {} to {}'.format(f, new_path))
    shutil.move(f, new_path) 

print('    done.')