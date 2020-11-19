//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/TilingSubtractiveColor" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 759
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _TileScaleParGrid;
uniform 	float _GridFineness;
uniform 	float _ChannelParColor;
uniform 	float _MaxGridAlpha;
uniform 	float _FinalColorScale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
float u_xlat3;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat4.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = _ChannelParColor * 0.00390625;
    u_xlat0 = u_xlat16_0 * vec4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / _ChannelParColor;
    u_xlat0 = u_xlat0 * vec4(u_xlat1);
    u_xlat0 = u_xlat0 * vec4(vec4(_FinalColorScale, _FinalColorScale, _FinalColorScale, _FinalColorScale));
    u_xlat1 = _TileScaleParGrid * _TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = vs_TEXCOORD1.y * u_xlat1 + 0.5;
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * _GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat3 = (-_MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    SV_Target0 = u_xlat0 * vec4(u_xlat1) + vec4(u_xlat3);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _TileScaleParGrid;
uniform 	float _GridFineness;
uniform 	float _ChannelParColor;
uniform 	float _MaxGridAlpha;
uniform 	float _FinalColorScale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
float u_xlat3;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat4.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = _ChannelParColor * 0.00390625;
    u_xlat0 = u_xlat16_0 * vec4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / _ChannelParColor;
    u_xlat0 = u_xlat0 * vec4(u_xlat1);
    u_xlat0 = u_xlat0 * vec4(vec4(_FinalColorScale, _FinalColorScale, _FinalColorScale, _FinalColorScale));
    u_xlat1 = _TileScaleParGrid * _TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = vs_TEXCOORD1.y * u_xlat1 + 0.5;
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * _GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat3 = (-_MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    SV_Target0 = u_xlat0 * vec4(u_xlat1) + vec4(u_xlat3);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	float _RenderViewportScaleFactor;
attribute highp vec3 in_POSITION0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _TileScaleParGrid;
uniform 	float _GridFineness;
uniform 	float _ChannelParColor;
uniform 	float _MaxGridAlpha;
uniform 	float _FinalColorScale;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
float u_xlat3;
vec2 u_xlat4;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat4.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = _ChannelParColor * 0.00390625;
    u_xlat0 = u_xlat16_0 * vec4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / _ChannelParColor;
    u_xlat0 = u_xlat0 * vec4(u_xlat1);
    u_xlat0 = u_xlat0 * vec4(vec4(_FinalColorScale, _FinalColorScale, _FinalColorScale, _FinalColorScale));
    u_xlat1 = _TileScaleParGrid * _TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = vs_TEXCOORD1.y * u_xlat1 + 0.5;
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * _GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat3 = (-_MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    SV_Target0 = u_xlat0 * vec4(u_xlat1) + vec4(u_xlat3);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
}