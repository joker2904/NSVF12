# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# just for debugging
DATA="Wineholder"
RES="200x200"
ARCH="nsvf_base"
SUFFIX="v1"
DATASET=/tmp/roy0/mountpoint/Dataset/${DATA}
SAVE=/tmp/roy0/mountpoint/savepoint/$DATA
MODEL=$ARCH$SUFFIX
MODEL_PATH=$SAVE/$MODEL/checkpoint_last.pt
NAME=WINEHOLDERMESH4

# CUDA_VISIBLE_DEVICES=0 \
python extract.py \
    --user-dir fairnr \
    --path ${MODEL_PATH} \
    --output ${SAVE} \
    --name ${NAME} \
    --format 'voxel_center' \
    --mc-threshold 0.5 \
    --mc-num-samples-per-halfvoxel 5 

