import subprocess
import os
from tqdm import tqdm

BAKTA_DB_PATH = 'bakta_db/db'
PROTEUS_GENOMES_PATH = 'proteus_strains/'
BAKTA_OUTPUTS_PATH = 'bakta_outputs/'
TMP_DIR = 'tmp/'

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
            
            # Remove files that are not .tsv or .log
            for file in os.listdir(output_folder):
                file_path = os.path.join(output_folder, file)
                if not (file.endswith('.tsv') or file.endswith('.log')):
                    os.remove(file_path)
        
    except subprocess.CalledProcessError as e:
        print(f"Error running bakta for {genome}: {e}")
            

genomes = os.listdir(PROTEUS_GENOMES_PATH)

for genome in tqdm(genomes):
    bakta_annotate(genome)

