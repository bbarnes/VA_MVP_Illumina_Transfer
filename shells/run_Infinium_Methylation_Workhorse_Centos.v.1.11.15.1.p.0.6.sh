#!/bin/bash

DRY_RUN=""
# DRY_RUN="TRUE"

#
# ----- ----- ----- ----- ----- ----- ----- ----- DOCKER IMAGES ----- ----- ----- ----- ----- ----- ----- -----
#
# IMG_VERS="1.11.15.1.p.0.4"
# IMG_VERS="1.11.15.1.p.0.4.10"
# IMG_VERS="1.11.15.1.p.0.4.11"
# After annoI/S and manifest update::
#
IMG_VERS="1.11.15.1.p.0.6.0"
# IMG_VERS="1.11.15.1.p.0.6.1" [Junk]
IMG_VERS="1.11.15.1.p.0.6.2"

IMG_NAME="Infinium_Methylation_Workhorse_Centos.v.${IMG_VERS}"
IMAGE="bbarnesimdocker/im_workhorse:${IMG_NAME}"
#
SCRIPT="run_swifthoof.sh"
SCRIPT="run_swifthoof.options.sh"

THIS_SCRIPT="$0"

#
# ----- ----- ----- ----- ----- ----- ----- ----- DIRECTORIES IDATS/OUTPUT ----- ----- ----- ----- ----- ----- ----- -----
#

# NOTE: Unlock a CHIP_VER and CHIP to run...
CHIP=""

# CHIP_VER="EPICv1"
# CHIP="206203800149" # [Done]
# CHIP="206203800185" # [Done]

CHIP_VER="EPICv2"
# CHIP="206891110001" # [Done]
# CHIP="206891110002" # [Done]
# CHIP="206891110003" # [Done]
# CHIP="206891110004" # [Done]
# CHIP="206891110005" # [Done]

# Full Set::
#  IDAT_DIR="/Users/bbarnes/Documents/data/idats/idats_EPIC_v2-20220912-Alpha"
#
# Auto Lighting::
IDAT_DIR="/Users/bbarnes/Documents/data/idats/idats_EPIC_v2-20220912-Alpha_subset"
IDATS="${IDAT_DIR}"

OUT_DIR="/Users/bbarnes/Documents/Projects.new/EPIC_v2/scratch/snps/docker-${IMG_VERS}/${CHIP_VER}"
OUT="${OUT_DIR}/full"
LOG="${OUT}/log.txt"

#
# Target Single Chip::
#
if [[ "${CHIP}" != "" ]]
then
    IDATS="${IDAT_DIR}/${CHIP}"
    OUT="${OUT_DIR}/chip-${CHIP}"
    LOG="${OUT}/log.txt"
fi

#
# ----- ----- ----- ----- ----- ----- ----- ----- RUN OPTIONS ----- ----- ----- ----- ----- ----- ----- -----
#
OPTS=""
# OPTS="${OPTS} --single "
OPTS="${OPTS} --fresh "
OPTS="${OPTS} --minPerc=96,98 --minPval=0.05,0.02 "
# OPTS="${OPTS} --platform=EPIC "
OPTS="${OPTS} --workflow=ind "
OPTS="${OPTS} --auto_detect "
OPTS="${OPTS} --write_snps "

VERBOSE="--verbose=2"
VERBOSE="--verbose=3"
VERBOSE="--verbose=4"
VERBOSE="--verbose=10"

#
# ----- ----- ----- ----- ----- ----- ----- ----- EXECUTE COMMAND ----- ----- ----- ----- ----- ----- ----- -----
#

echo
echo "Run Options:: '${THIS_SCRIPT}'"
echo
echo "DRY: '${DRY_RUN}'"
echo "IMG: '${IMAGE}'"
echo "SCR: '${SCRIPT}'"
echo "DAT: '${IDATS}'"
echo "CHP: '${CHIP}'"
echo 
echo "OUT: '${OUT}'"
echo "OPT: '${OPTS}'"
echo "VER: '${VERBOSE}'"
echo "LOG: '${LOG}'"
echo

if [[ "${DRY_RUN}" == "" ]]
then

    # Ensure we can write the log to output directory::
    mkdir -p ${OUT}
    # TBD:: Copy this script into run directory...
    cp ${THIS_SCRIPT} ${OUT}

    docker run -i --rm \
       -v ${IDATS}:/work \
       -v ${IDATS}:/input \
       -v ${OUT}:/output \
       -w /work \
       ${IMAGE} ${SCRIPT} ${OPTS} \
       ${VERBOSE} \
       &> ${LOG}
fi

echo ""
echo "Finished Shell..."
echo ""

exit

# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# This is just for show as a simple example::
#
# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

exit

IMG="bbarnesimdocker/im_workhorse:Infinium_Methylation_Workhorse_Centos.v.1.11.15.1.p.0.4"
DAT="PATH_TO_YOUR_IDAT_DIRECTORY"
OUT="PATH_TO_YOUR_OUTPUT_DIRECTORY"
LOG="PATH_TO_YOUR_LOG_OUTPUT_FILE"

# These options are only avaialbel if you use SCRIPT="run_swifthoof.options.sh"
OPT="--fresh --minPerc=96,98 --minPval=0.05,0.02 "

# Set to whatever level you want
VER="--verbose=3"

# Run Standard Version::
# SCRIPT="run_swifthoof.sh"

# Run to Allow Options::
SCRIPT="run_swifthoof.options.sh"

docker run -i --rm \
       -v ${DAT}:/work \
       -v ${DAT}:/input \
       -v ${OUT}:/output \
       -w /work \
       ${IMG} ${SCRIPT} ${OPT} \
       --auto_detect \
       ${VER} \
       &> ${LOG}

echo ""
echo "Finished Shell..."
echo ""

# End of file
