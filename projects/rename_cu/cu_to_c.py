import inspect, os, shutil

this_file = inspect.getfile( inspect.currentframe() )
this_path = os.path.abspath( this_file )
working_directory = os.path.dirname( this_path )

print('running {} ...'.format(this_file))
print('working directory : {}'.format(working_directory))

src_dir = os.path.abspath( os.path.join( working_directory, '../../src') )
cache_file = os.path.join( working_directory, 'rename_list.txt')

rename_list = []
for r, ds, fs in os.walk(src_dir):
    for f in fs:
        if f.endswith('.cu'):
            new_name = f.replace('.cu', '.c')
        elif f.endswith('.cuh'):
            new_name = f.replace('.cuh', '.h')
        else:
            continue
        old_path = os.path.join(r, f)
        new_path = os.path.join(r, new_name)
        print('    rename "{}"  to "{}"'.format(old_path, new_path))
        rename_list.append(new_path)
        shutil.move(old_path, new_path)

with open(cache_file, 'w') as f_h:
    f_h.write('\n'.join(rename_list))
    print('    writing all changes into {}'.format(cache_file))

print('    done.')
