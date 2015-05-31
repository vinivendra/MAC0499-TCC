
var btn;

function load() {

    var earth = sphere.template();
    earth.color = "blue";
    earth.position = [0, 0, -2];
    earth.radius = 1;

    var moon = earth.create();
    moon.color = "dark gray";
    moon.radius = 0.5;
    moon.position = [0, 2, 0];

    var satelite = new box();
    satelite.color = "light gray";
    satelite.scale = 0.2;
    satelite.position = [0.7, 0, 0];

    var spaaace = new box();
    spaaace.color = [0.6, 0.6, 1];
    spaaace.scale = 0.3;
    spaaace.position = [0, 1, 0];

    earth.addItem(moon);
    moon.addItem(satelite);
    satelite.addItem(spaaace);

    var instance1 = earth.create();
    instance1.position = [-1.3, 0, 0];

    var instance2 = earth.create();
    instance2.position = [ 1.3, 0, 0];

//    btn = UIButton.create();
//    btn.position = [300, 200];
//    btn.size = [100, 100];
//    btn.string = "JUMP!";
//
//    sli = UISlider.create();
//    print(sli);
//    print(UISlider);
//    sli.position = [50, 300];
//    sli.size = [200, 50];
//    sli.maximumValue = 50;
//    sli.minimumValue = -10;
}

function update() {

}

function tap(items, hits) {
    items[0].scale = items[0].scale.times(1.1);
}

function swipe(direction, items, swipes) {
    var item = items[0];

    var dict = {"0": 0, "Y": 1, "z": 0};

    if (direction == up) {
        item.position = item.position.plus(new vector(dict));
    }
    else if (direction == down) {
        item.position = item.position.plus(new vector([0, -1, 0]));
    }
    else if (direction == left) {
        item.position = item.position.plus(new vector([-1, 0, 0]));
    }
    else if (direction == right) {
        item.position = item.position.plus(new vector([1, 0, 0]));
    }
}

function pan(translation) {
    var resized = translation.times(0.02);
    var newPosition = resized.translate(instance.position);
    instance.position = newPosition;
}

function pinch(scale) {
    instance.radius = instance.radius * scale;
}

function rotate(angle) {
    instance.rotate({"0":0, "1":0, "2":1, "a":angle});
}

function longPress(translation) {
    instance.position = instance.position.plus(translation.times(0.02));
}

function contact(left, right, contact) {

}

//function button(pressedButton) {
//    if (pressedButton == btn) {
//        moon.velocity = [0, 5, 0];
//    }
//    else {
//        console.log("outro botaum.");
//    }
//}
//
//function slider(slider) {
//    print(slider.value);
//}