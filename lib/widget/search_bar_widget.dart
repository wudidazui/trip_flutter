import 'package:flutter/material.dart';

//home 首页默认状态
//homeLight 首页上滑后状态
//normal 默认状态
enum SearchBarType { home, normal, homeLight }

class SearchBarWidget extends StatefulWidget {
  //是否隐藏左侧返回键
  final bool? hideLeft;
  //搜索框类型
  final SearchBarType searchBarType;
  //提示文案
  final String? hint;
  //默认内容
  final String? defaultText;
  //左侧按钮点击回调
  final void Function()? leftButtonClick;
  //右侧按钮点击回调
  final void Function()? rightButtonClick;
  //输入框点击回调
  final void Function()? inputBoxClick;
  //内容发生变化的回调
  final ValueChanged<String>? onChanged;

  const SearchBarWidget(
      {super.key,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.inputBoxClick,
      this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //左侧返回按钮
          _wrapTap(
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: _backBtn,
              ),
              widget.leftButtonClick),
          //输入框
          Expanded(child: _inputBox),
          //搜索按钮
          _wrapTap(
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "搜索",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              widget.rightButtonClick)
        ],
      );

  get _backBtn => widget.hideLeft ?? false
      ? null
      : Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
          size: 26,
        );

  get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(0xffa9a9a9)
                  : Colors.blue),
          Expanded(child: _textField),
          if (showClear)
            _wrapTap(
                Icon(
                  Icons.clear,
                  size: 22,
                  color: Colors.grey,
                ), () {
              setState(() {
                _controller.clear();
                _onChanged('');
              });
            })
        ],
      ),
    );
  }

  get _homeSearchBar => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //城市
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                child: Row(
                  children: [
                    Text(
                      "北京",
                      style: TextStyle(color: _homeFontColor, fontSize: 16),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor,
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick),
          //输入框
          Expanded(child: _inputBox),
          _wrapTap(
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text("登出",
                    style: TextStyle(color: _homeFontColor, fontSize: 15)),
              ),
              widget.rightButtonClick)
        ],
      );

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _controller,
          onChanged: _onChanged,
          autofocus: true,
          cursorColor: Colors.blue,
          cursorHeight: 20,
          style: TextStyle(
            height: 1.3,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 5,
                bottom: 16,
                right: 5,
              ),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 15)),
        )
      : _wrapTap(
          Text(
            widget.defaultText ?? "",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputBoxClick);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  _wrapTap(Widget? child, void Function()? callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
