if [ -z "$1" ]; then
  echo "Usage: ./make_module.sh module_name"
  exit 1
fi

NAME=$(basename $1)
UPPER=$(echo "$NAME" \
  | tr '_' ' ' \
  | awk '{for(i=1;i<=NF;i++){ $i = toupper(substr($i,1,1)) substr($i,2)}; print}' \
  | tr -d ' ')
# MODULE=$(basename $1)            # test
# UPPER=$(echo "$MODULE" | sed -E 's/(^|_)([a-z])/\U\2/g')


# Create folders
mkdir -p lib/$NAME/screen
mkdir -p lib/$NAME/controller

touch lib/$NAME/$NAME.dart
touch lib/$NAME/screen/${NAME}_screen.dart
touch lib/$NAME/controller/${NAME}_controller.dart

cat <<EOF > lib/$NAME/$NAME.dart
export 'screen/${NAME}_screen.dart';
export 'controller/${NAME}_controller.dart';
EOF

cat <<EOF > lib/$NAME/controller/${NAME}_controller.dart
import 'package:get/get.dart';

class ${UPPER}Controller extends GetxController {
  // TODO: Add logic here
}
EOF

cat <<EOF > lib/$NAME/screen/${NAME}_screen.dart
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

echo "Module '$NAME' created successfully!"
