set -e -u -o pipefail

TENSOR_DIR="${DERIVATIVES_DIR}/07_tensor_fitting"
PARCELLATION_DIR="${DERIVATIVES_DIR}/08_mask_propagation"

SNAPSHOTS_DIR="${DERIVATIVES_DIR}/999_snapshots"
mkdir -p "$SNAPSHOTS_DIR"

FA="${TENSOR_DIR}/tensor_fa.nii.gz"
ADC="${TENSOR_DIR}/tensor_adc.nii.gz"
VEC="${TENSOR_DIR}/tensor_v1.nii.gz"
T2="${TENSOR_DIR}/T2_in_DWI.nii.gz"
MASK="${PARCELLATION_DIR}/tissue_segmentation_in_dwi.nii.gz"

x_dim=$(fslval "$ADC" dim1)
y_dim=$(fslval "$ADC" dim2)
z_dim=$(fslval "$ADC" dim3)

num_slices=$(fslval "$ADC" dim3)

x_center=$((x_dim / 2))
y_center=$((y_dim / 2))
z_center=$((z_dim / 2))


#for (( i=0; i<$num_slices; i++ )); do
#    output_png=$(printf "${SNAPSHOTS_DIR}/parcellation_%04d.png" $i)
#
#    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
#    -of "$output_png" \
#    -s ortho \
#    --voxelLoc "$x_center" "$y_center" "$i" \
#    -sz 600 900 \
#    -xh -yh \
#    -zz 785 \
#    -hc \
#    -hl \
#    "$MASK" -ot label --lut freesurfercolorlut --outlineWidth 1 --volume 0
#done
#
#
#for (( i=0; i<$num_slices; i++ )); do
#    output_png=$(printf "${SNAPSHOTS_DIR}/T2_%04d.png" $i)
#
#    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
#    -of "$output_png" \
#    -s ortho \
#    --voxelLoc "$x_center" "$y_center" "$i" \
#    -sz 600 900 \
#    -xh -yh \
#    -zz 785 \
#    -hc \
#    -hl \
#    "$T2" -ot volume -cm greyscale -dr 0 1500 
#done


################################# cFA ######################################

for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/cFA_coronal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$i" "$z_center" \
    -sz 600 900 \
    -xh -zh \
    -zz 785 \
    -hc \
    -hl \
    "$VEC" -ot rgbvector -b 60 -c 70
done


for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/cFA_sagittal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$i" "$y_center" "$z_center" \
    -sz 600 900 \
    -zh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$VEC" -ot rgbvector -b 60 -c 70
done



for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/cFA_axial_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$y_center" "$i" \
    -sz 600 900 \
    -xh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$VEC" -ot rgbvector -b 60 -c 70
done




################################# FA ######################################


for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/FA_axial_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$y_center" "$i" \
    -sz 600 900 \
    -xh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$FA" -ot volume -cm greyscale -dr 0 1
done

for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/FA_coronal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$i" "$z_center" \
    -sz 600 900 \
    -xh -zh \
    -zz 785 \
    -hc \
    -hl \
    "$FA" -ot volume -cm greyscale -dr 0 1
done

for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/FA_sagittal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$i" "$y_center" "$z_center" \
    -sz 600 900 \
    -zh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$FA" -ot volume -cm greyscale -dr 0 1
done


################################# MD ######################################


for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/MD_axial_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$y_center" "$i" \
    -sz 600 900 \
    -xh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$ADC" -ot volume -cm greyscale -dr 0 0.003
done

for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/MD_coronal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$x_center" "$i" "$z_center" \
    -sz 600 900 \
    -xh -zh \
    -zz 785 \
    -hc \
    -hl \
    "$ADC" -ot volume -cm greyscale -dr 0 0.003
done


for (( i=0; i<$num_slices; i++ )); do
    output_png=$(printf "${SNAPSHOTS_DIR}/MD_sagittal_%04d.png" $i)

    PYTHONWARNINGS=ignore MPLBACKEND=Agg render \
    -of "$output_png" \
    -s ortho \
    --voxelLoc "$i" "$y_center" "$z_center" \
    -sz 600 900 \
    -zh -yh \
    -zz 785 \
    -hc \
    -hl \
    "$ADC" -ot volume -cm greyscale -dr 0 0.003
done

