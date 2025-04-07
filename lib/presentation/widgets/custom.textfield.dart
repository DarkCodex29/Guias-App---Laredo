import 'package:app_guias/core/constants/app.colors.dart';
import 'package:flutter/material.dart';

enum TextFieldType {
  text,
  number,
  email,
  password,
  phone,
  search,
  multiline,
  selection
}

/// Widget de entrada de texto personalizado con funciones avanzadas
///
/// Proporciona una experiencia de usuario enriquecida con características como:
/// - Autocompletado con sugerencias
/// - Validación y mensajes de error
/// - Estados de carga
/// - Personalización visual consistente
/// - Diferentes tipos de entrada (texto, número, email, contraseña, etc.)
class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextFieldType? type;
  final TextInputType? keyboardType;
  final bool enabled;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final int? maxLength;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final List<String>? suggestions;
  final ValueChanged<String>? onSuggestionSelected;
  final bool enableSuggestions;
  final double maxSuggestionsHeight;
  final bool isLoading;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool readOnly;
  final String? prefixText;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool toUpperCase;

  const CustomTextField({
    required this.label,
    this.hint,
    this.controller,
    this.type,
    this.keyboardType,
    this.enabled = true,
    this.actionIcon,
    this.onActionPressed,
    this.maxLength,
    this.errorText,
    this.onChanged,
    this.suggestions,
    this.onSuggestionSelected,
    this.enableSuggestions = false,
    this.maxSuggestionsHeight = 200,
    this.isLoading = false,
    this.maxLines = 1,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.autofocus = false,
    this.readOnly = false,
    this.prefixText,
    this.prefix,
    this.suffix,
    this.textAlign = TextAlign.start,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderRadius,
    this.fillColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.toUpperCase = false,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;
  List<String> _filteredSuggestions = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _obscureText = widget.type == TextFieldType.password;

    // Si la opción de mayúsculas está habilitada, convertir el texto inicial
    if (widget.toUpperCase && _controller.text.isNotEmpty) {
      final String upperText = _controller.text.toUpperCase();
      if (upperText != _controller.text) {
        _controller.text = upperText;
      }
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus &&
          widget.enableSuggestions &&
          widget.suggestions != null) {
        _filterSuggestions(_controller.text);
        setState(() {
          _isFocused = true;
        });
      } else {
        setState(() {
          _isFocused = false;
        });
      }
    });

    if (widget.enableSuggestions && widget.suggestions != null) {
      _filterSuggestions('');
    }
  }

  void _filterSuggestions(String query) {
    if (widget.suggestions == null) return;

    if (query.isEmpty) {
      _filteredSuggestions = widget.suggestions!;
    } else {
      _filteredSuggestions = widget.suggestions!
          .where((suggestion) =>
              suggestion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        widget.controller!.text != _controller.text) {
      _controller.text = widget.controller!.text;
      setState(() {});
    }

    if (widget.suggestions != oldWidget.suggestions &&
        widget.enableSuggestions) {
      _filterSuggestions(_controller.text);
    }
  }

  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType!;
    }

    switch (widget.type) {
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (!widget.enableSuggestions ||
        widget.suggestions == null ||
        widget.suggestions!.isEmpty) {
      return;
    }

    _removeOverlay();

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final modalContext = context.findAncestorWidgetOfExactType<Dialog>();
    final maxWidth = modalContext != null ? size.width : size.width;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: maxWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.primary,
                width: 1.5,
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxSuggestionsHeight,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _filteredSuggestions[index];
                  return InkWell(
                    onTap: () {
                      _controller.text = suggestion;
                      widget.onSuggestionSelected?.call(suggestion);
                      _removeOverlay();
                      _focusNode.unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: index < _filteredSuggestions.length - 1
                                ? Colors.black12
                                : Colors.transparent,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        suggestion,
                        style: widget.style ??
                            const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(error: AppColors.red),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: widget.labelStyle ??
                      const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (widget.maxLength != null)
                  Text(
                    '${_controller.text.length}/${widget.maxLength}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _isFocused = hasFocus;
                  if (hasFocus) {
                    _showOverlay();
                  } else {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _removeOverlay();
                    });
                  }
                });
              },
              child: TextFormField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: _getKeyboardType(),
                enabled: widget.enabled,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                obscureText: _obscureText,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                onChanged: (value) {
                  String processedValue =
                      widget.toUpperCase ? value.toUpperCase() : value;

                  if (widget.toUpperCase && value != processedValue) {
                    final cursorPos = _controller.selection.baseOffset;

                    _controller.value = TextEditingValue(
                      text: processedValue,
                      selection: TextSelection.collapsed(
                        offset: cursorPos,
                      ),
                    );
                  }

                  widget.onChanged?.call(processedValue);
                  if (widget.suggestions != null) {
                    _filterSuggestions(processedValue);
                    if (_isFocused) {
                      _showOverlay();
                    }
                  }
                },
                onEditingComplete: widget.onEditingComplete,
                onFieldSubmitted: widget.onSubmitted,
                validator: widget.validator,
                autofocus: widget.autofocus,
                readOnly: widget.readOnly,
                textAlign: widget.textAlign,
                style: widget.style,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: widget.hintStyle ??
                      const TextStyle(color: AppColors.greyText),
                  prefixText: widget.prefixText,
                  prefix: widget.prefix,
                  suffix: widget.suffix,
                  filled: true,
                  fillColor: Colors.white,
                  counterText: '',
                  contentPadding: widget.contentPadding,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(isFocused: true),
                  errorBorder: _buildInputBorder(isError: true),
                  focusedErrorBorder:
                      _buildInputBorder(isError: true, isFocused: true),
                  suffixIcon: _buildSuffixIcon(),
                  isDense: true,
                ),
              ),
            ),
            if (widget.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Text(
                  widget.errorText!,
                  style: widget.errorStyle ??
                      const TextStyle(
                        color: AppColors.red,
                        fontSize: 12,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    if (widget.type == TextFieldType.password) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
      );
    }

    if (widget.actionIcon != null) {
      return GestureDetector(
        onTap: widget.onActionPressed,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              widget.actionIcon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
      );
    }

    if (widget.enableSuggestions &&
        widget.suggestions != null &&
        widget.suffix == null) {
      return GestureDetector(
        onTap: () {
          if (_controller.text.isNotEmpty) {
            _controller.clear();
            _filterSuggestions('');
            widget.onChanged?.call('');
          }
          if (_isFocused) {
            _showOverlay();
          } else {
            _focusNode.requestFocus();
          }
        },
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
      );
    }

    return widget.suffix;
  }

  OutlineInputBorder _buildInputBorder({
    bool isError = false,
    bool isFocused = false,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      borderSide: BorderSide(
        color: _getBorderColor(isError, isFocused),
        width: 1.5,
      ),
    );
  }

  Color _getBorderColor(bool isError, bool isFocused) {
    if (isError || widget.errorText != null) {
      return widget.errorBorderColor ?? AppColors.red;
    }
    if (isFocused) {
      return widget.focusedBorderColor ?? AppColors.primary;
    }
    return widget.enabledBorderColor ?? AppColors.primary.withOpacity(0.5);
  }
}
