import subprocess
import os
from tqdm import tqdm

BAKTA_DB_PATH = 'annotation/bakta_db/db'
PROTEUS_GENOMES_PATH = 'annotation/proteus_strains/'
BAKTA_OUTPUTS_PATH = 'annotation/bakta_outputs/'
TMP_DIR = 'annotation/tmp/'

def bakta_annotate(genome):
    genome_path = os.path.join(PROTEUS_GENOMES_PATH, genome)
    output_folder = os.path.join(BAKTA_OUTPUTS_PATH, os.path.splitext(genome)[0])

    run_bakta = [
        'bakta',
        '--db', BAKTA_DB_PATH,
        '--output', output_folder,
        '--tmp-dir', TMP_DIR,
        '--genus', 'Proteus',
        '--species', 'mirabilis',
        '--skip-plot',
        genome_path
    ]

    try:
            subprocess.run(run_bakta, check=True)
    
    except subprocess.CalledProcessError as e:
        print(f"Error running bakta for {genome}: {e}")
            

genomes = os.listdir(PROTEUS_GENOMES_PATH)

for genome in tqdm(genomes):
    bakta_annotate(genome)

