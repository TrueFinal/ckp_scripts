#!/bin/bash

echo "Script para automatização da execução do comando "cpsizeme run" em ambientes Checkpoint na versão R81.20"
echo "Por padrão, este script executa um cpsizeme de 24 horas"
echo "Para mais informações ou acesso ao código fonte, visite: https://github.com/TrueFinal/ckp_scripts"

# Diretório padrão de armazenagem dos arquivos gerados
OUTPUT_DIR="/var/log/cpsizeme_reports"
mkdir -p "${OUTPUT_DIR}"

# Nome do arquivo com timestamp
REPORT_NAME="cpsizeme-report-$(date +%F).tar"
OUTPUT_PATH="${OUTPUT_DIR}/${REPORT_NAME}"

# Define a duração da execução do comando para 24 horas (tempo em minutos) 
DURATION=60

echo "=============================================="
echo " Iniciando CPSIZEME com duração de 24 horas..."
echo " O arquivo gerado será salvo em: ${OUTPUT_PATH}"
echo "=============================================="

# Executa o comando cpsizeme por 24 horas (tempo em minutos)
cpsizeme run -o "${OUTPUT_PATH}" -t "${DURATION}"

# Verifica se o comando foi concluído com sucesso ou gera menssagem de erro
if [ $? -eq 0 ]; then
    echo "=============================================="
    echo " CPSIZEME concluído com sucesso!"
    echo " Arquivo gerado em: ${OUTPUT_PATH}"
    echo "=============================================="
else
    echo "=============================================="
    echo " Houve um problema durante a execução do CPSIZEME."
    echo " Verifique logs e parâmetros."
    echo "=============================================="
fi
