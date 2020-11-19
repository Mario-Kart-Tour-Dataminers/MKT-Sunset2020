//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マシンパーツ/MachineParts_Wing_Ghost" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map", 2D) = "black" { }
_NumberTex ("Number Map", 2D) = "black" { }
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_Decal ("Decal(UV1)", 2D) = "black" { }
_AlphaFactor ("アルファ強度", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 2
}
SubShader {
 LOD 2500
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 2500
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 405055
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 28024
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_26) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    u_xlat16_2 = u_xlat4.y * u_xlat4.y;
    u_xlat16_2 = u_xlat4.x * u_xlat4.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_9.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_9.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_9.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_29) + u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_10.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_10.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD2.w = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bool u_xlatb9;
mediump vec3 u_xlat16_10;
int u_xlati19;
float u_xlat27;
int u_xlati27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_32;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat27 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<_WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati27 ; u_xlati_loop_1++)
    {
        u_xlat28 = float(u_xlati_loop_1);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = _WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = u_xlat29 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat28 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_32 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_32 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_32);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_32 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_32) + u_xlat16_5.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_10.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 82419
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    SV_Target0.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 148334
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 224927
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2.x);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-u_xlat16_6.xyz) + vs_TEXCOORD4.xyz;
    u_xlat21 = vs_TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD5 = max(u_xlat16_3, u_xlat0.x);
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp float vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_0.xyz = texture2D(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat10_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat0.x = vs_TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.699999988;
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
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 2500
  Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 322188
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
int u_xlati15;
float u_xlat21;
int u_xlati21;
bool u_xlatb21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat21 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<_WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati21 ; u_xlati_loop_1++)
    {
        u_xlat22 = float(u_xlati_loop_1);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = _WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = u_xlat23 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat22 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD4.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_draw_buffers
#extension GL_EXT_draw_buffers : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _WingExtraParam;
uniform lowp sampler2D _NumberTex;
uniform lowp sampler2D _Decal;
uniform mediump sampler2D unity_Lightmap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
#define SV_Target1 gl_FragData[1]
#define SV_Target2 gl_FragData[2]
#define SV_Target3 gl_FragData[3]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
bvec2 u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
int u_xlati17;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
float u_xlat26;
mediump float u_xlat16_29;
void main()
{
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xxyy, vec4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = _WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = vs_TEXCOORD0.yxx * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(-0.170000002, -0.159999996, -0.165000007);
    u_xlat1.w = u_xlat24 * 0.100000001 + u_xlat1.x;
    u_xlat10_2.xyz = texture2D(_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<_WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 4 : 3;
    u_xlat3.xyz = u_xlat10_2.xyz;
    for(int u_xlati_loop_1 = 1 ; u_xlati_loop_1<u_xlati24 ; u_xlati_loop_1++)
    {
        u_xlat25 = float(u_xlati_loop_1);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = _WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = u_xlat26 * 0.100000001 + u_xlat1.x;
        u_xlat4.x = u_xlat25 * 0.0450000018 + u_xlat1.y;
        u_xlat10_4.xyz = texture2D(_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + u_xlat10_4.xyz;
    }
    u_xlat0.xyz = vec3(0.0, 1.5, 0.0) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat0.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD0.yyyy, vec4(0.879999995, 0.600000024, 0.0, 0.0)).xy;
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD0.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_29 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_29 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_29);
    u_xlat16_7.xyz = unity_SHC.xyz * vec3(u_xlat16_29) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    SV_Target0.xyz = u_xlat16_5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3.w = 1.0;
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
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
}
}
}
Fallback "Booster/Black"
}