// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:zoomable_image_cropper/zoomable_image_cropper.dart';
import 'package:zoomable_image_cropper/src/container_grid_lines.dart';

class CustomZoomableImage extends StatelessWidget {
  final ZoomableImageCropperController controller;
  const CustomZoomableImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    print(controller.aspectRatio.toString());

    double scale = 1;
    if (controller.aspectRatio < 2) {
      scale = 1.3;
    }
    if (controller.aspectRatio == 1) {
      scale = 1;
    }

    if (controller.aspectRatio < 1) {
      scale = 1.5;
    }

    return SizedBox(
      height: controller.containerHeight,
      width: controller.containerWidth,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Center(
            child: Transform.scale(
              scale: scale,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio,
                  child: InteractiveViewer(
                    onInteractionUpdate: (details) {
                      controller.onInteractionUpdate?.call(details);
                      if (controller.showResizeGrid) {
                        controller.showGrid$.add(true);
                      }
                    },
                    constrained: false,
                    clipBehavior: Clip.none,
                    transformationController:
                        controller.transformationController,
                    minScale: 0.1,
                    maxScale: 4.0,
                    scaleEnabled: true,
                    panEnabled: true,
                    child: Image(
                      image: controller.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomZoomableCropper extends StatelessWidget {
  final ZoomableImageCropperController controller;
  const CustomZoomableCropper({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomZoomableImage(
          controller: controller,
        ),
        if (controller.showResizeGrid)
          IgnorePointer(
            ignoring: true,
            child: ContainerGridLines(
              showGrid$: controller.showGrid$,
              containerHeight: controller.containerHeight,
              containerWidth: controller.containerWidth,
            ),
          )
      ],
    );
  }
}
