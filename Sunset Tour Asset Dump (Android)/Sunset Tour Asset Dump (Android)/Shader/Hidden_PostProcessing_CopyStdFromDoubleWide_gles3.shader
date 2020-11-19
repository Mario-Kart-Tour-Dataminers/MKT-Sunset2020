//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/CopyStdFromDoubleWide" {
Properties {
_MainTex ("", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 59924
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = texture(_MainTex, vs_TEXCOORD0.xy);
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 127784
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _UVScaleOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _UVScaleOffset.xy + _UVScaleOffset.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    SV_Target0 = (u_xlatb1.x) ? vec4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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