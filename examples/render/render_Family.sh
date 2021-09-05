# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# just for debugging
DATA="Family"
RES="200x200"
ARCH="nsvf_base"
SUFFIX="v1"
DATASET=/tmp/roy0/mountpoint/Dataset/${DATA}
SAVE=/tmp/roy0/mountpoint/savepoint/$DATA
MODEL=$ARCH$SUFFIX
MODEL_PATH=$SAVE/$MODEL/checkpoint_last.pt
NAME=VoxelColorRender

# CUDA_VISIBLE_DEVICES=0 \
python render.py ${DATASET} \
    --user-dir fairnr \
    --task single_object_rendering \
    --path ${MODEL_PATH} \
    --render-beam 1 \
    --render-save-fps 24 \
    --render-camera-poses ${DATASET}/pose \
    --render-views "0..150" \
    --model-overrides '{"chunk_size":256,"raymarching_tolerance":0.01}' \
    --render-resolution $RES \
    --render-output ${SAVE}/output \
    --render-output-types "color" "point" \
    --render-combine-output --log-format "simple"\

