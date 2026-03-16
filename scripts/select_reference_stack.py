import os
import sys
import nibabel as nib
import numpy as np

subject = sys.argv[1]
session = sys.argv[2]

mask_axial_run_01 = f"envau/work/meca/data/BaboFet_BIDS/derivatives/svrtk/dwi/{subject}/{session}/{subject}_{session}_dir-AP_run-01_desc-brain_mask.nii.gz"
mask_axial_run_02 = f"envau/work/meca/data/BaboFet_BIDS/derivatives/svrtk/dwi/{subject}/{session}/{subject}_{session}_dir-AP_run-02_desc-brain_mask.nii.gz"

if not os.path.exists(mask_axial_run_01):
    print(f"{subject}_{session}_dir-AP_run-01")
elif not os.path.exists(mask_axial_run_02):
    print(f"{subject}_{session}_dir-AP_run-02")
else:
    mask_axial_run_01_data = nib.load(mask_axial_run_01).get_fdata()
    mask_axial_run_02_data = nib.load(mask_axial_run_02).get_fdata()

    edge_counts_run01 = []
    edge_counts_run02 = []

    for axis in range(3):
        edge_counts_run01.append(np.count_nonzero(mask_axial_run_01_data.take(indices=0, axis=axis)))
        edge_counts_run01.append(np.count_nonzero(mask_axial_run_01_data.take(indices=-1, axis=axis)))

        edge_counts_run02.append(np.count_nonzero(mask_axial_run_02_data.take(indices=0, axis=axis)))
        edge_counts_run02.append(np.count_nonzero(mask_axial_run_02_data.take(indices=-1, axis=axis)))

    total_edge_voxels_run01 = sum(edge_counts_run01)
    total_edge_voxels_run02 = sum(edge_counts_run02)
    if total_edge_voxels_run01 <= total_edge_voxels_run02:
        print(f"{subject}_{session}_dir-AP_run-01")
    else:
        print(f"{subject}_{session}_dir-AP_run-02")