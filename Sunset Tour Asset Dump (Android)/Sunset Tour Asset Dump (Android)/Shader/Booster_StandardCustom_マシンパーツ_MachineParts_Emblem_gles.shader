//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マシンパーツ/MachineParts_Emblem" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map", 2D) = "black" { }
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_Decal ("Decal(UV1)", 2D) = "black" { }
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 128
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 15006
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_21;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat32 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb32 = u_xlat32<9.99999975e-06;
    u_xlat32 = (u_xlatb32) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat16_1.x * u_xlat32;
    u_xlat4.x = u_xlat16_1.z * u_xlat32;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat32 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat3.xyz = vec3(u_xlat32) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_1.y) + 1.0;
    u_xlatb30 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_31);
    u_xlat16_31 = u_xlat10_3.w + -1.0;
    u_xlat16_31 = unity_SpecCube0_HDR.w * u_xlat16_31 + 1.0;
    u_xlat16_31 = u_xlat16_31 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_21 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_21) + u_xlat16_1.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.xyw = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat32 = u_xlat30;
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat30)) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_21) + u_xlat16_9.xyz;
    u_xlat16_21 = (-u_xlat32) + 1.0;
    u_xlat16_0 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_0 = u_xlat16_21 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_21 * u_xlat16_0;
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyw + u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
float u_xlat18;
mediump float u_xlat16_19;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_19 = (-u_xlat16_19) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_19);
    u_xlat16_19 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_11.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_11.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = u_xlat16_7.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat16_19) + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_1.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
float u_xlat18;
mediump float u_xlat16_19;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_19 = (-u_xlat16_19) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_19);
    u_xlat16_19 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_11.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_11.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = u_xlat16_7.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat16_19) + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_1.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_1.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat16_1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_1.y) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb2) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat10_3.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat11.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_28 = (-u_xlat3.x) + 1.0;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_28 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.xyw = vec3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_11) * u_xlat16_1.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat2.xxx * _LightColor0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyw;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
float u_xlat12;
float u_xlat20;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat3.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_1.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat16_1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat2.x = (-u_xlat16_1.y) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = u_xlat2.x * u_xlat3.x;
    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat12);
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat20 + 1.00001001;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat10_11.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_11.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat29 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat11;
lowp vec3 u_xlat10_11;
float u_xlat12;
float u_xlat20;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat3.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_1.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat16_1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat2.x = (-u_xlat16_1.y) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = u_xlat2.x * u_xlat3.x;
    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat12);
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat20 + 1.00001001;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat10_11.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_11.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat29 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_10;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat27;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat10.xyz);
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_1.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + u_xlat16_1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_1.y) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat27 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb2) ? 0.0 : u_xlat27;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_3.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat10.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_25 = (-u_xlat3.x) + 1.0;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_25 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + 1.0;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.xyw = vec3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_10) * u_xlat16_1.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_1.xyw;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat2.xxx * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat23;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
float u_xlat39;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_2.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_31) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat9.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat9.xyz * u_xlat3.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat9.xyz = u_xlat3.xxx * u_xlat9.xyz;
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat13.x = u_xlat33 * u_xlat33;
    u_xlat23 = (-u_xlat16_1.y) + 1.0;
    u_xlat33 = u_xlat23 * u_xlat23;
    u_xlat39 = u_xlat33 * u_xlat33 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat39 + 1.00001001;
    u_xlat39 = u_xlat23 * u_xlat23 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat39;
    u_xlat3.x = u_xlat13.x * u_xlat3.x;
    u_xlat3.x = u_xlat33 / u_xlat3.x;
    u_xlat16_1.x = u_xlat23 * u_xlat33;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat3.xyw = u_xlat16_8.xyz * u_xlat3.xyw;
    u_xlat39 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat3.xyw = u_xlat3.xyw * vec3(u_xlat39) + u_xlat16_4.xyz;
    u_xlat16_11.x = dot((-u_xlat9.xyz), u_xlat0.xyz);
    u_xlat16_11.x = u_xlat16_11.x + u_xlat16_11.x;
    u_xlat16_4.xyz = u_xlat0.xyz * (-u_xlat16_11.xxx) + (-u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat9.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_11.x = (-u_xlat0.x) + 1.0;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_5.xyz = u_xlat16_11.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat0.x = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.z;
    u_xlat9.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat0.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat9.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_4.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat23<0.00499999989;
    u_xlat23 = u_xlat23 * 8.29800034;
    u_xlat16_11.x = (u_xlatb30) ? 0.0 : u_xlat23;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_0.w + -1.0;
    u_xlat16_11.x = unity_SpecCube0_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = u_xlat16_11.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_11.xxx;
    u_xlat16_11.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_11.xyz * u_xlat16_1.xxx;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat3.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat23;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
float u_xlat39;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_2.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_31) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat9.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat9.xyz * u_xlat3.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat9.xyz = u_xlat3.xxx * u_xlat9.xyz;
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat13.x = u_xlat33 * u_xlat33;
    u_xlat23 = (-u_xlat16_1.y) + 1.0;
    u_xlat33 = u_xlat23 * u_xlat23;
    u_xlat39 = u_xlat33 * u_xlat33 + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat39 + 1.00001001;
    u_xlat39 = u_xlat23 * u_xlat23 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat39;
    u_xlat3.x = u_xlat13.x * u_xlat3.x;
    u_xlat3.x = u_xlat33 / u_xlat3.x;
    u_xlat16_1.x = u_xlat23 * u_xlat33;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat3.xyw = u_xlat16_8.xyz * u_xlat3.xyw;
    u_xlat39 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat3.xyw = u_xlat3.xyw * vec3(u_xlat39) + u_xlat16_4.xyz;
    u_xlat16_11.x = dot((-u_xlat9.xyz), u_xlat0.xyz);
    u_xlat16_11.x = u_xlat16_11.x + u_xlat16_11.x;
    u_xlat16_4.xyz = u_xlat0.xyz * (-u_xlat16_11.xxx) + (-u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat9.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_11.x = (-u_xlat0.x) + 1.0;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_11.x * u_xlat16_11.x;
    u_xlat16_5.xyz = u_xlat16_11.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat0.x = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_4.z : (-u_xlat16_4.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.z;
    u_xlat9.xy = (-u_xlat16_4.xy) * u_xlat16_4.yz;
    u_xlat0.yz = (-u_xlat16_4.xy) * u_xlat16_4.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat9.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_4.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat23<0.00499999989;
    u_xlat23 = u_xlat23 * 8.29800034;
    u_xlat16_11.x = (u_xlatb30) ? 0.0 : u_xlat23;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_11.x);
    u_xlat16_11.x = u_xlat10_0.w + -1.0;
    u_xlat16_11.x = unity_SpecCube0_HDR.w * u_xlat16_11.x + 1.0;
    u_xlat16_11.x = u_xlat16_11.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_11.xxx;
    u_xlat16_11.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_11.xyz * u_xlat16_1.xxx;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat3.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat29 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb29 = u_xlat29<9.99999975e-06;
    u_xlat29 = (u_xlatb29) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat16_1.x * u_xlat29;
    u_xlat4.x = u_xlat16_1.z * u_xlat29;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat29 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_1.y) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat10_3.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_2.www * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.xyw = vec3(u_xlat16_10) + (-u_xlat16_8.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_9) * u_xlat16_1.xyw + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat16_1.xyw;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat11;
float u_xlat18;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat11;
float u_xlat18;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_12;
float u_xlat14;
float u_xlat31;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat1.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_32 = (u_xlatb0) ? 0.0 : u_xlat33;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_32);
    u_xlat16_32 = u_xlat10_3.w + -1.0;
    u_xlat16_32 = unity_SpecCube0_HDR.w * u_xlat16_32 + 1.0;
    u_xlat16_32 = u_xlat16_32 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_32);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_32 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_12 = (-u_xlat16_32) + u_xlat16_2.y;
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_12) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat14 = u_xlat0.x;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat0.xxx) + u_xlat10.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat14) + 1.0;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_35;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_2.xyw = u_xlat16_0.xxx * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat4.xxx * _LightColor0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_9.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat14;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat32;
float u_xlat35;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat10_4.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.www * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat5.x = vs_TEXCOORD2.w;
    u_xlat5.y = vs_TEXCOORD3.w;
    u_xlat5.z = vs_TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat5.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat14.xyz = u_xlat8.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat5.xxx * u_xlat8.xyz;
    u_xlat5.x = dot(u_xlat14.xyz, u_xlat14.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat14.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat14.x = u_xlat32 * u_xlat32;
    u_xlat23 = (-u_xlat16_2.y) + 1.0;
    u_xlat32 = u_xlat23 * u_xlat23;
    u_xlat35 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat14.x = u_xlat14.x * u_xlat35 + 1.00001001;
    u_xlat35 = u_xlat23 * u_xlat23 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat35;
    u_xlat5.x = u_xlat14.x * u_xlat5.x;
    u_xlat5.x = u_xlat32 / u_xlat5.x;
    u_xlat16_28 = u_xlat23 * u_xlat32;
    u_xlat16_28 = (-u_xlat16_28) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat35 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat8.z = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    u_xlat8.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat0.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat23<0.00499999989;
    u_xlat23 = u_xlat23 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat23;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_28);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyw + u_xlat5.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat14;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat32;
float u_xlat35;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat10_4.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.www * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat5.x = vs_TEXCOORD2.w;
    u_xlat5.y = vs_TEXCOORD3.w;
    u_xlat5.z = vs_TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat5.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat14.xyz = u_xlat8.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat5.xxx * u_xlat8.xyz;
    u_xlat5.x = dot(u_xlat14.xyz, u_xlat14.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat14.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat14.x = u_xlat32 * u_xlat32;
    u_xlat23 = (-u_xlat16_2.y) + 1.0;
    u_xlat32 = u_xlat23 * u_xlat23;
    u_xlat35 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat14.x = u_xlat14.x * u_xlat35 + 1.00001001;
    u_xlat35 = u_xlat23 * u_xlat23 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat35;
    u_xlat5.x = u_xlat14.x * u_xlat5.x;
    u_xlat5.x = u_xlat32 / u_xlat5.x;
    u_xlat16_28 = u_xlat23 * u_xlat32;
    u_xlat16_28 = (-u_xlat16_28) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat35 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat8.z = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    u_xlat8.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat0.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat23<0.00499999989;
    u_xlat23 = u_xlat23 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat23;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_28);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyw + u_xlat5.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat26 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb26 = u_xlat26<9.99999975e-06;
    u_xlat26 = (u_xlatb26) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat3.z = u_xlat16_1.x * u_xlat26;
    u_xlat4.x = u_xlat16_1.z * u_xlat26;
    u_xlat3.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat4.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat3.xyz = vec3(u_xlat26) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_1.y) + 1.0;
    u_xlatb24 = u_xlat4.z<0.00499999989;
    u_xlat26 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_3.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat4.x = u_xlat8 * u_xlat8;
    u_xlat8 = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat8 = u_xlat8 * 16.0;
    u_xlat16_25 = (-u_xlat26) + 1.0;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_25 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + 1.0;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.xyw = vec3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = vec3(u_xlat16_16) * u_xlat16_1.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_8.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_1.xyw;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat11;
float u_xlat18;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat11;
float u_xlat18;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat29;
bool u_xlatb29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat2.x) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat4.z = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.z * u_xlat2.x;
    u_xlat4.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat2.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_1.y) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat2.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat2.x * u_xlat2.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = vec3(u_xlat16_28) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_1.xyw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
mediump vec3 u_xlat16_13;
float u_xlat28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat1.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb0) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_29);
    u_xlat16_29 = u_xlat10_3.w + -1.0;
    u_xlat16_29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
    u_xlat16_29 = u_xlat16_29 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat9.xyz, u_xlat1.xyz);
    u_xlat13 = u_xlat0.x;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat0.xxx) + u_xlat9.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_32 = (-u_xlat13) + 1.0;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_32;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_2.xyw = u_xlat16_0.xxx * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_7.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat1.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat4.xxx * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat35;
float u_xlat39;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat10_4.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.www * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_31 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_31 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_31);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat10_4 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_31 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat5.x = vs_TEXCOORD2.w;
    u_xlat5.y = vs_TEXCOORD3.w;
    u_xlat5.z = vs_TEXCOORD4.w;
    u_xlat9.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat15.xyz = u_xlat9.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat9.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat5.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat15.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15.x = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_2.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15.x = u_xlat15.x * u_xlat39 + 1.00001001;
    u_xlat39 = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat39;
    u_xlat5.x = u_xlat15.x * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_31 = u_xlat25 * u_xlat35;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat39 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat39) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat9.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat9.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    u_xlat9.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat0.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat9.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat25;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyw + u_xlat5.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat35;
float u_xlat39;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_1.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = unity_SHC.xyz * u_xlat16_1.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat10_4.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.www * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_31 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_31 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_31);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat10_4 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_31 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat5.x = vs_TEXCOORD2.w;
    u_xlat5.y = vs_TEXCOORD3.w;
    u_xlat5.z = vs_TEXCOORD4.w;
    u_xlat9.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat15.xyz = u_xlat9.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat9.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat5.x = dot(u_xlat15.xyz, u_xlat15.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat15.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15.x = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_2.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15.x = u_xlat15.x * u_xlat39 + 1.00001001;
    u_xlat39 = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat39;
    u_xlat5.x = u_xlat15.x * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_31 = u_xlat25 * u_xlat35;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat39 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat39) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat9.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat0.xyz * (-u_xlat16_1.xxx) + (-u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat9.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.z;
    u_xlat9.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat0.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat9.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat9.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat25;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyw + u_xlat5.xyw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_20;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat4.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat28 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_29);
    u_xlat16_29 = u_xlat10_3.w + -1.0;
    u_xlat16_29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
    u_xlat16_29 = u_xlat16_29 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat28 = u_xlat27;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_20 = (-u_xlat28) + 1.0;
    u_xlat16_9 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_9 = u_xlat16_20 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_20 * u_xlat16_9;
    u_xlat16_20 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_20) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_1.www * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_11) + (-u_xlat16_8.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_9) * u_xlat16_2.xyw + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(u_xlat16_20) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
mediump float u_xlat16_11;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_20 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_20);
    u_xlat16_20 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_20) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = max(u_xlat19, 0.00100000005);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat9 = max(u_xlat19, 0.319999993);
    u_xlat9 = u_xlat27 * u_xlat9;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat18 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_20) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10.xxx + u_xlat16_2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
mediump float u_xlat16_11;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_20 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_20);
    u_xlat16_20 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_20) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_4 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_4 = u_xlat10_4 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat19 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat19 = max(u_xlat19, 0.00100000005);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat9 = max(u_xlat19, 0.319999993);
    u_xlat9 = u_xlat27 * u_xlat9;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat18 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(u_xlat16_20) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10.xxx + u_xlat16_2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
float u_xlat27;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb1 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_29);
    u_xlat16_29 = u_xlat10_3.w + -1.0;
    u_xlat16_29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
    u_xlat16_29 = u_xlat16_29 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat1.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat1.xxx) + u_xlat10.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_10;
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_10) * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
float u_xlat12;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat10.xyz = u_xlat3.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat1.x = (-u_xlat16_2.y) + 1.0;
    u_xlatb30 = u_xlat1.x<0.00499999989;
    u_xlat4.x = u_xlat1.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_32 = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat12);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat1.x = u_xlat1.x * u_xlat10.x;
    u_xlat10.x = u_xlat12 * u_xlat12;
    u_xlat19 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat19 + 1.00001001;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat3.x / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
float u_xlat12;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat10.xyz = u_xlat3.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat1.x = (-u_xlat16_2.y) + 1.0;
    u_xlatb30 = u_xlat1.x<0.00499999989;
    u_xlat4.x = u_xlat1.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_32 = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat12);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat1.x = u_xlat1.x * u_xlat10.x;
    u_xlat10.x = u_xlat12 * u_xlat12;
    u_xlat19 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat19 + 1.00001001;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat3.x / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat24;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb1 = u_xlat4.z<0.00499999989;
    u_xlat27 = u_xlat4.z * 8.29800034;
    u_xlat16_26 = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_3.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_26);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat9.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat1.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat1.xxx) + u_xlat9.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_26 = (-u_xlat3.x) + 1.0;
    u_xlat16_9 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_9 = u_xlat16_26 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_26 * u_xlat16_9;
    u_xlat16_26 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_26) + u_xlat16_2.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_9) * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_26 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat1.xxx * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
float u_xlat12;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat10.xyz = u_xlat3.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat1.x = (-u_xlat16_2.y) + 1.0;
    u_xlatb30 = u_xlat1.x<0.00499999989;
    u_xlat4.x = u_xlat1.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_32 = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat12);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat1.x = u_xlat1.x * u_xlat10.x;
    u_xlat10.x = u_xlat12 * u_xlat12;
    u_xlat19 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat19 + 1.00001001;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat3.x / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_3 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_3, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_7.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.xy = u_xlat1.yx;
    vs_TEXCOORD4.x = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD4.z = u_xlat2.w;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
lowp vec3 u_xlat10_10;
float u_xlat12;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat4.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat10.xyz = u_xlat3.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat1.x = (-u_xlat16_2.y) + 1.0;
    u_xlatb30 = u_xlat1.x<0.00499999989;
    u_xlat4.x = u_xlat1.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? 0.0 : u_xlat4.x;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_32 = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat12 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat12);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat1.x = u_xlat1.x * u_xlat10.x;
    u_xlat10.x = u_xlat12 * u_xlat12;
    u_xlat19 = u_xlat3.x * u_xlat3.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat19 + 1.00001001;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat3.x / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat10_10.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_10.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_3 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_3, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_7.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat4.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat28 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_29);
    u_xlat16_29 = u_xlat10_3.w + -1.0;
    u_xlat16_29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
    u_xlat16_29 = u_xlat16_29 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat28 = u_xlat27;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat27)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_29 = (-u_xlat28) + 1.0;
    u_xlat16_9 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_9 = u_xlat16_29 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_29 * u_xlat16_9;
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_1.www * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_11) + (-u_xlat16_8.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_9) * u_xlat16_2.xyw + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat16_2.xyw;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat10.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat1.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat10.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat1.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
float u_xlat30;
mediump float u_xlat16_32;
float u_xlat33;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb1 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_32 = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_32);
    u_xlat16_32 = u_xlat10_3.w + -1.0;
    u_xlat16_32 = unity_SpecCube0_HDR.w * u_xlat16_32 + 1.0;
    u_xlat16_32 = u_xlat16_32 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_32);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat1.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat1.xxx) + u_xlat11.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_32 = (-u_xlat3.x) + 1.0;
    u_xlat16_11 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_11 = u_xlat16_32 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_32 * u_xlat16_11;
    u_xlat16_32 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_12 = (-u_xlat16_32) + u_xlat16_2.y;
    u_xlat16_12 = u_xlat16_12 + 1.0;
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_12) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_11) * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat4.xxx * _LightColor0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_9.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4.y;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat13;
float u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
float u_xlat35;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.zzz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_32 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_32 = (-u_xlat16_32) + u_xlat16_4.y;
    u_xlat16_32 = u_xlat16_32 + 1.0;
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_32);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _NormalRand.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat9.xyz = u_xlat5.xyz * u_xlat13.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15 = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_4.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat9.x = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15 = u_xlat15 * u_xlat9.x + 1.00001001;
    u_xlat9.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_32 = u_xlat25 * u_xlat35;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat13.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat0.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.xyw = u_xlat16_4.xxx * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.z;
    u_xlat9.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat0.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat3.x = u_xlat25 * 8.29800034;
    u_xlat16_2.x = (u_xlatb30) ? 0.0 : u_xlat3.x;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_4.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyw + u_xlat5.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4.y;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat13;
float u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
float u_xlat35;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.zzz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_32 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_32 = (-u_xlat16_32) + u_xlat16_4.y;
    u_xlat16_32 = u_xlat16_32 + 1.0;
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_32);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _NormalRand.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat9.xyz = u_xlat5.xyz * u_xlat13.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15 = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_4.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat9.x = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15 = u_xlat15 * u_xlat9.x + 1.00001001;
    u_xlat9.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_32 = u_xlat25 * u_xlat35;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat13.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat0.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.xyw = u_xlat16_4.xxx * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.z;
    u_xlat9.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat0.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat3.x = u_xlat25 * 8.29800034;
    u_xlat16_2.x = (u_xlatb30) ? 0.0 : u_xlat3.x;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_4.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyw + u_xlat5.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4.y;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_16;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
bool u_xlatb25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat25 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb25 = u_xlat25<9.99999975e-06;
    u_xlat25 = (u_xlatb25) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat25 * u_xlat16_2.x;
    u_xlat4.x = u_xlat25 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat25 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb24 = u_xlat4.z<0.00499999989;
    u_xlat25 = u_xlat4.z * 8.29800034;
    u_xlat16_26 = (u_xlatb24) ? 0.0 : u_xlat25;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_26);
    u_xlat16_26 = u_xlat10_3.w + -1.0;
    u_xlat16_26 = unity_SpecCube0_HDR.w * u_xlat16_26 + 1.0;
    u_xlat16_26 = u_xlat16_26 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_26);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat25 = u_xlat24;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat4.x = u_xlat8 * u_xlat8;
    u_xlat8 = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat8 = u_xlat8 * 16.0;
    u_xlat16_26 = (-u_xlat25) + 1.0;
    u_xlat16_16 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_16 = u_xlat16_26 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_26 * u_xlat16_16;
    u_xlat16_26 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_10 = (-u_xlat16_26) + u_xlat16_2.y;
    u_xlat16_10 = u_xlat16_10 + 1.0;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_16) * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_8.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_26 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat10.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat1.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat1.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat1.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat27 = (-u_xlat16_2.y) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_5.x);
    u_xlat16_5.x = u_xlat10_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = max(u_xlat10.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat10.x;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat18 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat1.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xxx;
    u_xlat16_2.xyw = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat9.xyz = u_xlat9.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_2.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyw + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _NormalRand.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat3.x;
    u_xlat3.x = u_xlat16_2.z * u_xlat3.x;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat3.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.xxx + u_xlat16_2.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat10_4.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat10_4.xyz, _MinMSA.xyz);
    u_xlat4.z = (-u_xlat16_2.y) + 1.0;
    u_xlatb1 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_29);
    u_xlat16_29 = u_xlat10_3.w + -1.0;
    u_xlat16_29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
    u_xlat16_29 = u_xlat16_29 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat1.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat1.xxx) + u_xlat10.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_29 = (-u_xlat3.x) + 1.0;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_29 * u_xlat16_10;
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + 1.0;
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_3 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_3 = u_xlat10_3 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.xyw = vec3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyw = vec3(u_xlat16_10) * u_xlat16_2.xyw + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_8.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat0.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = unity_Lightmap_HDR.xxx * u_xlat16_13.xyz + u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_2.xyw;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_29 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_29) * _LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat4.xxx * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4.y;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat13;
float u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
float u_xlat35;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.zzz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_32 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_32 = (-u_xlat16_32) + u_xlat16_4.y;
    u_xlat16_32 = u_xlat16_32 + 1.0;
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_32);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _NormalRand.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat9.xyz = u_xlat5.xyz * u_xlat13.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15 = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_4.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat9.x = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15 = u_xlat15 * u_xlat9.x + 1.00001001;
    u_xlat9.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_32 = u_xlat25 * u_xlat35;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.xyw = u_xlat16_4.xxx * _LightColor0.xyz;
    u_xlat5.xyw = u_xlat16_4.xyw * u_xlat5.xyw;
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat13.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat0.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.xyw = u_xlat16_4.xxx * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.z;
    u_xlat9.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat0.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat3.x = u_xlat25 * 8.29800034;
    u_xlat16_2.x = (u_xlatb30) ? 0.0 : u_xlat3.x;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_4.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyw + u_xlat5.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4.y;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat12 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.z * u_xlat2.y;
    u_xlat0.x = u_xlat1.y * u_xlat2.z + (-u_xlat0.x);
    u_xlat1.w = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD2.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD4.x = u_xlat2.z;
    vs_TEXCOORD3.yz = u_xlat1.wy;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4.y = max(u_xlat12, u_xlat16_3);
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat13;
float u_xlat15;
float u_xlat25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_32;
float u_xlat35;
void main()
{
    u_xlat0.z = vs_TEXCOORD3.z;
    u_xlat0.x = vs_TEXCOORD4.z;
    u_xlat0.y = vs_TEXCOORD2.z;
    u_xlat1.y = vs_TEXCOORD4.x;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD3.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD2.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD3.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD4.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture2D(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_3.xyz = texture2D(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat10_3.xyz, _MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.zzz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_3.xyz + _AddColor.xyz;
    u_xlat10_1 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_1 = u_xlat10_1 * _Color + _AddColor;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_1.xyz;
    u_xlat16_6.xyz = u_xlat16_1.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_32 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_32 = (-u_xlat16_32) + u_xlat16_4.y;
    u_xlat16_32 = u_xlat16_32 + 1.0;
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_32);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = vs_TEXCOORD2.w;
    u_xlat3.y = vs_TEXCOORD3.w;
    u_xlat3.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _NormalRand.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat9.xyz = u_xlat5.xyz * u_xlat13.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat9.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat15 = u_xlat35 * u_xlat35;
    u_xlat25 = (-u_xlat16_4.y) + 1.0;
    u_xlat35 = u_xlat25 * u_xlat25;
    u_xlat9.x = u_xlat35 * u_xlat35 + -1.0;
    u_xlat15 = u_xlat15 * u_xlat9.x + 1.00001001;
    u_xlat9.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat5.x = u_xlat35 / u_xlat5.x;
    u_xlat16_32 = u_xlat25 * u_xlat35;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.xyw = u_xlat16_4.xxx * _LightColor0.xyz;
    u_xlat5.xyw = u_xlat16_4.xyw * u_xlat5.xyw;
    u_xlat5.xyw = u_xlat5.xyw * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat13.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat0.x) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.xyw = u_xlat16_4.xxx * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat9.z = u_xlat0.x * u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.z;
    u_xlat9.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat0.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xxx + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat25<0.00499999989;
    u_xlat3.x = u_xlat25 * 8.29800034;
    u_xlat16_2.x = (u_xlatb30) ? 0.0 : u_xlat3.x;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_4.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyw + u_xlat5.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4.y;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 106722
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_8;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat10_10.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_3.xy = max(u_xlat10_10.xy, _MinMSA.xy);
    u_xlat0.y = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat10_5.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = _Color.xyz * u_xlat10_5.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_16 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(u_xlat16_16) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat10_2.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat10_2.xy, _MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + 1.0;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12 + 1.5;
    u_xlat4.x = u_xlat16_12 * u_xlat4.x;
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_2.x + -1.0;
    u_xlat8 = u_xlat8 * u_xlat16_12 + 1.00001001;
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = u_xlat16_2.x / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat10_2.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat10_2.xy, _MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + 1.0;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12 + 1.5;
    u_xlat4.x = u_xlat16_12 * u_xlat4.x;
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_2.x + -1.0;
    u_xlat8 = u_xlat8 * u_xlat16_12 + 1.00001001;
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = u_xlat16_2.x / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_8;
lowp vec2 u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat10_10.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_3.xy = max(u_xlat10_10.xy, _MinMSA.xy);
    u_xlat0.y = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat10_5.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = _Color.xyz * u_xlat10_5.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_4.xyz = (-u_xlat16_8.xyz) + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_8.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_16 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(u_xlat16_16) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat10_2.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat10_2.xy, _MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + 1.0;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12 + 1.5;
    u_xlat4.x = u_xlat16_12 * u_xlat4.x;
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_2.x + -1.0;
    u_xlat8 = u_xlat8 * u_xlat16_12 + 1.00001001;
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = u_xlat16_2.x / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat12 = vs_TEXCOORD8;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _Decal_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
varying highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy * _Decal_ST.xy + _Decal_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Decal;
uniform lowp sampler2D _MSA;
uniform lowp sampler2D _BumpMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp float vs_TEXCOORD8;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat10_0.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat10_2.xy = texture2D(_MSA, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat10_2.xy, _MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + 1.0;
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12 + 1.5;
    u_xlat4.x = u_xlat16_12 * u_xlat4.x;
    u_xlat16_12 = u_xlat16_2.x * u_xlat16_2.x + -1.0;
    u_xlat8 = u_xlat8 * u_xlat16_12 + 1.00001001;
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = u_xlat16_2.x / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_2.xyz + _AddColor.xyz;
    u_xlat10_2 = texture2D(_Decal, vs_TEXCOORD1.zw);
    u_xlat16_2 = u_xlat10_2 * _Color + _AddColor;
    u_xlat16_3.xyz = (-u_xlat16_5.xyz) + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat16_1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat12 = vs_TEXCOORD8;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
}
Fallback "Booster/Black"
}