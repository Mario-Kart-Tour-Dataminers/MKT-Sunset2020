//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/TilingTextureColor" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 4401
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _ColorThreshold;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Clut;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat2.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.577350259;
    u_xlat0.x = (-u_xlat16_0.x) * _ColorThreshold + 1.0;
    u_xlat0.y = 0.0;
    u_xlat16_0.xyz = texture(_Clut, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _ColorThreshold;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Clut;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat2.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.577350259;
    u_xlat0.x = (-u_xlat16_0.x) * _ColorThreshold + 1.0;
    u_xlat0.y = 0.0;
    u_xlat16_0.xyz = texture(_Clut, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
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
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _TileScale;
uniform 	float _ColorThreshold;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Clut;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _MainTex_TexelSize.x / _MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * _TileScale;
    u_xlat0.y = _TileScale;
    u_xlat2.xy = vs_TEXCOORD1.xy / u_xlat0.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    SV_Target0.w = u_xlat16_0.w;
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.577350259;
    u_xlat0.x = (-u_xlat16_0.x) * _ColorThreshold + 1.0;
    u_xlat0.y = 0.0;
    u_xlat16_0.xyz = texture(_Clut, u_xlat0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}