# Filling Slider

[![pub.dev points](https://badges.bar/filling_slider/pub%20points)](https://pub.dev/packages/filling_slider/score)
[![pub.dev likes](https://badges.bar/filling_slider/likes)](https://pub.dev/packages/filling_slider/score)
[![pub.dev popularity](https://badges.bar/filling_slider/popularity)](https://pub.dev/packages/filling_slider/score)  
This is IOS-like slider widget

<a href="https://ivansupervan.github.io/filling_slider/" target="_blank">Demo</a>

![Example gif](https://github.com/IvanSupervan/filling_slider/blob/main/img/slider.gif?raw=true)

## How to use

### Simple vertical slider

```
FillingSlider()
```

### Simple horizontal slider

```
FillingSlider(
  direction: FillingSliderDirection.horizontal
)
```

## Props

You can set initial value of slider in range [0.0, 1.0]

```
double initialValue
```

### Visual Props

You can change size, direction and color of slider

```
double width
```

```
double height
```

```
Color color
```

```
Color fillColor
```

```
SliderDirection direction
```

### Callbacks Props

There are 2 methods to respond to a change in the value of the slider

```
Function onChange - Notifies about all slider changes
```

```
Function onFinish - Notifies about the end of changes
```

### Child Props

```
Widget child
```

```
Function childBuilder
```
