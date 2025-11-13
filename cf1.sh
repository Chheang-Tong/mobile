#!/bin/bash

# Check arg
if [ -z "$1" ]; then
  echo "Usage: ./cf.sh path/module_name"
  echo "Example: ./cf.sh features/test"
  exit 1
fi

FULL_PATH="$1"                 # e.g. features/test
NAME=$(basename "$FULL_PATH")  # => test
UPPER=$(echo "$NAME" \
  | tr '_' ' ' \
  | awk '{for(i=1;i<=NF;i++){ $i = toupper(substr($i,1,1)) substr($i,2)}; print}' \
  | tr -d ' ')

# UPPER=$(echo "$NAME" | sed -E 's/(^|_)([a-z])/\U\2/g')  # test -> Test, user_profile -> UserProfile

# DEBUG (you can remove these later)
echo "FULL_PATH = $FULL_PATH"
echo "NAME      = $NAME"
echo "UPPER     = $UPPER"

BASE_DIR="lib/$FULL_PATH"      # => lib/features/test

# Create folders
mkdir -p "$BASE_DIR/screen"
mkdir -p "$BASE_DIR/controller"

# Create files
touch "$BASE_DIR/$NAME.dart"
touch "$BASE_DIR/screen/${NAME}_screen.dart"
touch "$BASE_DIR/controller/${NAME}_controller.dart"

# Barrel file
cat <<EOF > "$BASE_DIR/$NAME.dart"
export 'screen/${NAME}_screen.dart';
export 'controller/${NAME}_controller.dart';
EOF

# Controller
cat <<EOF > "$BASE_DIR/controller/${NAME}_controller.dart"
import 'package:get/get.dart';

class ${UPPER}Controller extends GetxController {
  // TODO: Add logic here
}
EOF

# Screen
cat <<EOF > "$BASE_DIR/screen/${NAME}_screen.dart"
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/${NAME}_controller.dart';

class ${UPPER}Screen extends StatelessWidget {
  final controller = Get.put(${UPPER}Controller());
  ${UPPER}Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$UPPER Screen')),
      body: Center(
        child: Text('This is $UPPER screen'),
      ),
    );
  }
}
EOF

echo "Module '$NAME' created successfully at $BASE_DIR"
