//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/アイテム/Thunder" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_FixedAmbientColor ("固定環境光色", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_SphereMap ("SphereMap", 2D) = "black" { }
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 58343
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_43 = u_xlat16_43 + 1.0;
    u_xlat16_43 = clamp(u_xlat16_43, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_43);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(u_xlat16_42) + u_xlat16_11.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0 = u_xlat16_42 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_42 * u_xlat16_0;
    u_xlat16_8.xyz = vec3(u_xlat16_0) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
lowp vec3 u_xlat10_10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat27 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat10.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_3.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = (-_Smoothness) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat29 = u_xlat27 * 8.29800034;
    u_xlat16_3.x = (u_xlatb28) ? 0.0 : u_xlat29;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_3.x);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_6.x = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xxx;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_10.xyz = texture2D(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_10.xyz + u_xlat10_10.xyz;
    u_xlat16_10.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = max(u_xlat10.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat9) + u_xlat16_3.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
lowp vec3 u_xlat10_10;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat27 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat10.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat10.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat10.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_30 = (-u_xlat1.x) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_3.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = (-_Smoothness) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat29 = u_xlat27 * 8.29800034;
    u_xlat16_3.x = (u_xlatb28) ? 0.0 : u_xlat29;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_3.x);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat27 * u_xlat27;
    u_xlat16_6.x = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xxx;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_10.xyz = texture2D(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_10.xyz + u_xlat10_10.xyz;
    u_xlat16_10.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = max(u_xlat10.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat9) + u_xlat16_3.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz;
    u_xlat16_42 = u_xlat16_43 + 1.0;
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_42);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_12;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_26 = u_xlat16_26 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_26);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat9.xyz;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat9.x = u_xlat25 * u_xlat25;
    u_xlat17 = (-_Smoothness) + 1.0;
    u_xlat25 = u_xlat17 * u_xlat17;
    u_xlat27 = u_xlat25 * u_xlat25 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat17 * u_xlat17 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat27;
    u_xlat1.x = u_xlat9.x * u_xlat1.x;
    u_xlat1.x = u_xlat25 / u_xlat1.x;
    u_xlat16_26 = u_xlat17 * u_xlat25;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_6.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlatb27 = u_xlat17<0.00499999989;
    u_xlat17 = u_xlat17 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? 0.0 : u_xlat17;
    u_xlat16_12.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12.x = u_xlat16_12.x + u_xlat16_12.x;
    u_xlat16_12.xyz = u_xlat0.xyz * (-u_xlat16_12.xxx) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat0.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat16_12.zxy, (-u_xlat16_12.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_12.z : (-u_xlat16_12.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_12.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_12.z;
    u_xlat3.xy = (-u_xlat16_12.xy) * u_xlat16_12.yz;
    u_xlat0.yz = (-u_xlat16_12.xy) * u_xlat16_12.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_12.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_4.x);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat1.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_12;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_26 = u_xlat16_26 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_26);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat9.xyz;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat9.x = u_xlat25 * u_xlat25;
    u_xlat17 = (-_Smoothness) + 1.0;
    u_xlat25 = u_xlat17 * u_xlat17;
    u_xlat27 = u_xlat25 * u_xlat25 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat17 * u_xlat17 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat27;
    u_xlat1.x = u_xlat9.x * u_xlat1.x;
    u_xlat1.x = u_xlat25 / u_xlat1.x;
    u_xlat16_26 = u_xlat17 * u_xlat25;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_6.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlatb27 = u_xlat17<0.00499999989;
    u_xlat17 = u_xlat17 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? 0.0 : u_xlat17;
    u_xlat16_12.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12.x = u_xlat16_12.x + u_xlat16_12.x;
    u_xlat16_12.xyz = u_xlat0.xyz * (-u_xlat16_12.xxx) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat0.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat16_12.zxy, (-u_xlat16_12.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_12.z : (-u_xlat16_12.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_12.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_12.z;
    u_xlat3.xy = (-u_xlat16_12.xy) * u_xlat16_12.yz;
    u_xlat0.yz = (-u_xlat16_12.xy) * u_xlat16_12.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_12.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_4.x);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat1.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_40 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_39) * u_xlat16_7.xyz;
    u_xlat16_39 = u_xlat16_40 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_39);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_39 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_39 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_39) * _LightColor0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat33) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_10.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_25);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_1.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_5.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.xyz = vec3(u_xlat16_9) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat0.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.z;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_25);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_1.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_5.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.xyz = vec3(u_xlat16_9) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat0.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz;
    u_xlat16_42 = u_xlat16_43 + 1.0;
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_42);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_12;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_26 = u_xlat16_26 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_26);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat9.xyz;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat9.x = u_xlat25 * u_xlat25;
    u_xlat17 = (-_Smoothness) + 1.0;
    u_xlat25 = u_xlat17 * u_xlat17;
    u_xlat27 = u_xlat25 * u_xlat25 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat17 * u_xlat17 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat27;
    u_xlat1.x = u_xlat9.x * u_xlat1.x;
    u_xlat1.x = u_xlat25 / u_xlat1.x;
    u_xlat16_26 = u_xlat17 * u_xlat25;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlatb27 = u_xlat17<0.00499999989;
    u_xlat17 = u_xlat17 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? 0.0 : u_xlat17;
    u_xlat16_12.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12.x = u_xlat16_12.x + u_xlat16_12.x;
    u_xlat16_12.xyz = u_xlat0.xyz * (-u_xlat16_12.xxx) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat0.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat16_12.zxy, (-u_xlat16_12.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_12.z : (-u_xlat16_12.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_12.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_12.z;
    u_xlat3.xy = (-u_xlat16_12.xy) * u_xlat16_12.yz;
    u_xlat0.yz = (-u_xlat16_12.xy) * u_xlat16_12.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_12.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_4.x);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat1.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat9;
mediump vec3 u_xlat16_12;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat16_26 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_26 = u_xlat16_26 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_26);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat3.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat9.xyz;
    u_xlat25 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat9.x = u_xlat25 * u_xlat25;
    u_xlat17 = (-_Smoothness) + 1.0;
    u_xlat25 = u_xlat17 * u_xlat17;
    u_xlat27 = u_xlat25 * u_xlat25 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat17 * u_xlat17 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat27;
    u_xlat1.x = u_xlat9.x * u_xlat1.x;
    u_xlat1.x = u_xlat25 / u_xlat1.x;
    u_xlat16_26 = u_xlat17 * u_xlat25;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlatb27 = u_xlat17<0.00499999989;
    u_xlat17 = u_xlat17 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? 0.0 : u_xlat17;
    u_xlat16_12.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12.x = u_xlat16_12.x + u_xlat16_12.x;
    u_xlat16_12.xyz = u_xlat0.xyz * (-u_xlat16_12.xxx) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat0.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat16_12.zxy, (-u_xlat16_12.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_12.z : (-u_xlat16_12.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_12.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_12.z;
    u_xlat3.xy = (-u_xlat16_12.xy) * u_xlat16_12.yz;
    u_xlat0.yz = (-u_xlat16_12.xy) * u_xlat16_12.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_12.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_4.x);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_26) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat1.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_39;
float u_xlat40;
bool u_xlatb40;
float u_xlat41;
bool u_xlatb41;
mediump float u_xlat16_46;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat40 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = sin(u_xlat40);
    u_xlat40 = u_xlat40 * _NormalRand.w;
    u_xlat40 = fract(u_xlat40);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat41 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat4.xyz = vec3(u_xlat41) * u_xlat2.xyz;
    u_xlat16_39 = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_39 = u_xlat16_39 + u_xlat16_39;
    u_xlat16_3.xyz = u_xlat4.xyz * (-vec3(u_xlat16_39)) + (-u_xlat1.xyz);
    u_xlat41 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb41 = u_xlat41<9.99999975e-06;
    u_xlat41 = (u_xlatb41) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat41 * u_xlat16_3.x;
    u_xlat6.x = u_xlat41 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat41 = inversesqrt(u_xlat41);
    u_xlat5.xyz = vec3(u_xlat41) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat40) + u_xlat16_3.xyz;
    u_xlat40 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat5.xyz = vec3(u_xlat40) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb40 = u_xlat6.z<0.00499999989;
    u_xlat41 = u_xlat6.z * 8.29800034;
    u_xlat16_39 = (u_xlatb40) ? 0.0 : u_xlat41;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat10_3.w + -1.0;
    u_xlat16_39 = unity_SpecCube0_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_3.xyz * vec3(u_xlat16_39);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_8.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture2D(_SphereMap, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_5.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * u_xlat10_5.xyz + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_46 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_39) * u_xlat16_8.xyz;
    u_xlat16_39 = u_xlat16_46 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + vec3(u_xlat16_39);
    u_xlat40 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat2.x = u_xlat40;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat40 = u_xlat40 + u_xlat40;
    u_xlat1.xyz = u_xlat4.xyz * (-vec3(u_xlat40)) + u_xlat1.xyz;
    u_xlat40 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
    u_xlat16_11.xyz = vec3(u_xlat40) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat6.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_12.xyz = u_xlat1.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_39 = (-u_xlat2.x) + 1.0;
    u_xlat16_1.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_1.x = u_xlat16_39 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_39 * u_xlat16_1.x;
    u_xlat16_9.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_12.xyz * u_xlat16_11.xyz + u_xlat16_0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat9;
float u_xlat16;
mediump float u_xlat16_21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat9.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat23 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat9.x = u_xlat23 * u_xlat23;
    u_xlat16 = (-_Smoothness) + 1.0;
    u_xlat23 = u_xlat16 * u_xlat16;
    u_xlat25 = u_xlat23 * u_xlat23 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat25 + 1.00001001;
    u_xlat25 = u_xlat16 * u_xlat16 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat25;
    u_xlat2.x = u_xlat9.x * u_xlat2.x;
    u_xlat2.x = u_xlat23 / u_xlat2.x;
    u_xlat16_21 = u_xlat16 * u_xlat23;
    u_xlat16_21 = (-u_xlat16_21) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat25) + u_xlat16_0.xyz;
    u_xlatb25 = u_xlat16<0.00499999989;
    u_xlat16 = u_xlat16 * 8.29800034;
    u_xlat16_0.x = (u_xlatb25) ? 0.0 : u_xlat16;
    u_xlat16_7 = dot((-u_xlat4.xyz), u_xlat1.xyz);
    u_xlat16_7 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_5.xyz = u_xlat1.xyz * (-vec3(u_xlat16_7)) + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_7 = (-u_xlat1.x) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat1.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat16_5.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat9;
float u_xlat16;
mediump float u_xlat16_21;
float u_xlat22;
float u_xlat23;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * _NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat9.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat23 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat9.x = u_xlat23 * u_xlat23;
    u_xlat16 = (-_Smoothness) + 1.0;
    u_xlat23 = u_xlat16 * u_xlat16;
    u_xlat25 = u_xlat23 * u_xlat23 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat25 + 1.00001001;
    u_xlat25 = u_xlat16 * u_xlat16 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat25;
    u_xlat2.x = u_xlat9.x * u_xlat2.x;
    u_xlat2.x = u_xlat23 / u_xlat2.x;
    u_xlat16_21 = u_xlat16 * u_xlat23;
    u_xlat16_21 = (-u_xlat16_21) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat25 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat25) + u_xlat16_0.xyz;
    u_xlatb25 = u_xlat16<0.00499999989;
    u_xlat16 = u_xlat16 * 8.29800034;
    u_xlat16_0.x = (u_xlatb25) ? 0.0 : u_xlat16;
    u_xlat16_7 = dot((-u_xlat4.xyz), u_xlat1.xyz);
    u_xlat16_7 = u_xlat16_7 + u_xlat16_7;
    u_xlat16_5.xyz = u_xlat1.xyz * (-vec3(u_xlat16_7)) + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_7 = (-u_xlat1.x) + 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_3.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_5.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat1.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22) + u_xlat16_5.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w;
    u_xlat0.y = vs_TEXCOORD2.w;
    u_xlat0.z = vs_TEXCOORD3.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_40 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_39) * u_xlat16_7.xyz;
    u_xlat16_39 = u_xlat16_40 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_39);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_39 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_39 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_39) * _LightColor0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat33) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_10.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_25);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_5.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.xyz = vec3(u_xlat16_9) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat0.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_25);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat28 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_1.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_5.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.xyz = vec3(u_xlat16_9) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat0.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_36;
float u_xlat37;
bool u_xlatb37;
float u_xlat38;
bool u_xlatb38;
mediump float u_xlat16_43;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = vs_TEXCOORD1.w;
    u_xlat1.y = vs_TEXCOORD2.w;
    u_xlat1.z = vs_TEXCOORD3.w;
    u_xlat37 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * _NormalRand.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat38 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat4.xyz = vec3(u_xlat38) * u_xlat2.xyz;
    u_xlat16_36 = dot((-u_xlat1.xyz), u_xlat4.xyz);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_36;
    u_xlat16_3.xyz = u_xlat4.xyz * (-vec3(u_xlat16_36)) + (-u_xlat1.xyz);
    u_xlat38 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb38 = u_xlat38<9.99999975e-06;
    u_xlat38 = (u_xlatb38) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat38 * u_xlat16_3.x;
    u_xlat6.x = u_xlat38 * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat6.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat38 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat5.xyz = vec3(u_xlat38) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_NormalDiff);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37) + u_xlat16_3.xyz;
    u_xlat37 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat5.xyz = vec3(u_xlat37) * u_xlat5.xyz;
    u_xlat6.z = (-_Smoothness) + 1.0;
    u_xlatb37 = u_xlat6.z<0.00499999989;
    u_xlat38 = u_xlat6.z * 8.29800034;
    u_xlat16_36 = (u_xlatb37) ? 0.0 : u_xlat38;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat5.xyz, u_xlat16_36);
    u_xlat16_36 = u_xlat10_3.w + -1.0;
    u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
    u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat10_3.xyz * vec3(u_xlat16_36);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_8.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_8.xy = u_xlat16_8.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_2.xyz = texture2D(_SphereMap, u_xlat16_8.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz + u_xlat10_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_5.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * u_xlat10_5.xyz + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_36 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_36) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_36) * u_xlat16_8.xyz;
    u_xlat16_36 = u_xlat16_43 + 1.0;
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + vec3(u_xlat16_36);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat2.x = u_xlat37;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat37 = u_xlat37 + u_xlat37;
    u_xlat1.xyz = u_xlat4.xyz * (-vec3(u_xlat37)) + u_xlat1.xyz;
    u_xlat37 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat6.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat6.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_11.xyz = u_xlat1.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_36 = (-u_xlat2.x) + 1.0;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_1.x;
    u_xlat16_9.xyz = u_xlat16_1.xxx * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_36 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * _LightColor0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat37) * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_11.xyz * u_xlat16_7.xyz + u_xlat16_0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_7.xyz;
    u_xlat28 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_0.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat4.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_7.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_7.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_7.z;
    u_xlat4.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat1.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_7.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat2.z;
    vs_TEXCOORD1.z = u_xlat1.y;
    vs_TEXCOORD2.x = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat2.y;
    vs_TEXCOORD2.z = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat4.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat28 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat28 + 1.00001001;
    u_xlat28 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat28;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_7.xyz;
    u_xlat28 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat28) + u_xlat16_0.xyz;
    u_xlatb28 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb28) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat4.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_7.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat4.z = u_xlat1.x * u_xlat16_7.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_7.z;
    u_xlat4.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat1.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_7.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + u_xlat2.xyw;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_43 = u_xlat16_43 + 1.0;
    u_xlat16_43 = clamp(u_xlat16_43, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_43);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat13.xyz = u_xlat0.xyz * (-vec3(u_xlat36)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(u_xlat16_42) + u_xlat16_11.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.y;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat28) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat5.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = (-_Smoothness) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_3.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat28 = u_xlat27 * u_xlat27;
    u_xlat16_6.x = u_xlat27 * u_xlat28;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xxx;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat10_3.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat1.x * u_xlat1.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat28 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = u_xlat16_7.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.y;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat28 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat28) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat28) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat5.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = (-_Smoothness) + 1.0;
    u_xlatb28 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat10_3 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_3.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_3.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat28 = u_xlat27 * u_xlat27;
    u_xlat16_6.x = u_xlat27 * u_xlat28;
    u_xlat27 = u_xlat27 * u_xlat27 + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xxx;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat10_3.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9.x = u_xlat1.x * u_xlat1.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat28 / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = u_xlat16_7.xyz * u_xlat9.xxx;
    u_xlat9.xyz = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3.y;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz;
    u_xlat16_42 = u_xlat16_43 + 1.0;
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_42);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat13.xyz = u_xlat0.xyz * (-vec3(u_xlat36)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.y;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_40 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_39) * u_xlat16_7.xyz;
    u_xlat16_39 = u_xlat16_40 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_39);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat12.xyz = u_xlat0.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat11 = u_xlat11 * u_xlat11;
    u_xlat5.x = u_xlat11 * u_xlat11;
    u_xlat11 = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat11 = u_xlat11 * 16.0;
    u_xlat16_10.xyz = vec3(u_xlat11) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_39 = (-u_xlat1.x) + 1.0;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_8.xyz = u_xlat16_11.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_11.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_39 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_39) * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.y;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.x = u_xlat1.x;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat0.x = u_xlat1.y * u_xlat2.w;
    u_xlat0.x = u_xlat2.y * u_xlat1.z + (-u_xlat0.x);
    u_xlat1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.x;
    vs_TEXCOORD1.z = u_xlat2.x;
    vs_TEXCOORD2.xy = u_xlat1.yx;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    vs_TEXCOORD2.z = u_xlat2.y;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat15, u_xlat16_3);
    vs_TEXCOORD3.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat2.y * u_xlat2.y;
    u_xlat16_3 = u_xlat2.x * u_xlat2.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz;
    u_xlat16_42 = u_xlat16_43 + 1.0;
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_42);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat13.xyz = u_xlat0.xyz * (-vec3(u_xlat36)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.y;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_6.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_6.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb37 = u_xlat37<9.99999975e-06;
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb36 = u_xlat5.z<0.00499999989;
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_42) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_42) * u_xlat16_7.xyz;
    u_xlat16_42 = u_xlat16_43 + 1.0;
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_42);
    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat36;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat13.xyz = u_xlat0.xyz * (-vec3(u_xlat36)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_11.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_42 = (-u_xlat1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_42;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_42 * u_xlat16_0.x;
    u_xlat16_8.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = unity_Lightmap_HDR.xxx * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3.y;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat2.xyw = u_xlat2.xyw * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_40 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_39) * u_xlat16_7.xyz;
    u_xlat16_39 = u_xlat16_40 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_39);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat12.xyz = u_xlat0.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat11 = u_xlat11 * u_xlat11;
    u_xlat5.x = u_xlat11 * u_xlat11;
    u_xlat11 = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat11 = u_xlat11 * 16.0;
    u_xlat16_10.xyz = vec3(u_xlat11) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_39 = (-u_xlat1.x) + 1.0;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_8.xyz = u_xlat16_11.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_11.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_39 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_39) * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.y;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_6.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_25 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_25 = u_xlat18 * u_xlat26;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_9 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_6.xyz = u_xlat0.xyz * (-vec3(u_xlat16_9)) + (-u_xlat3.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_9 = (-u_xlat0.x) + 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat10_0 = textureCube(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3.y;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
void main()
{
    u_xlat0.z = vs_TEXCOORD2.z;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.y = vs_TEXCOORD1.z;
    u_xlat1.y = vs_TEXCOORD3.x;
    u_xlat1.z = vs_TEXCOORD1.x;
    u_xlat1.x = vs_TEXCOORD2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xzy * vs_TEXCOORD2.yyy;
    u_xlat1.y = u_xlat0.x;
    u_xlat1.xz = vs_TEXCOORD1.xz;
    u_xlat10_3.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3.y = u_xlat0.z;
    u_xlat3.xz = vs_TEXCOORD2.xz;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat0.xz = vs_TEXCOORD3.xz;
    u_xlat1.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat3.x = vs_TEXCOORD1.w;
    u_xlat3.y = vs_TEXCOORD2.w;
    u_xlat3.z = vs_TEXCOORD3.w;
    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat0.xyz * (-u_xlat16_2.xxx) + (-u_xlat3.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_2.x);
    u_xlat16_6.x = u_xlat10_2.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_2.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat10_4.xyz + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_39 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_40 = (-u_xlat16_39) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_39) * u_xlat16_7.xyz;
    u_xlat16_39 = u_xlat16_40 + 1.0;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_39);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat12.xyz = u_xlat0.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat11 = u_xlat11 * u_xlat11;
    u_xlat5.x = u_xlat11 * u_xlat11;
    u_xlat11 = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat11 = u_xlat11 * 16.0;
    u_xlat16_10.xyz = vec3(u_xlat11) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_39 = (-u_xlat1.x) + 1.0;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_11.x = u_xlat16_39 * u_xlat16_11.x;
    u_xlat16_8.xyz = u_xlat16_11.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat16_8.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = unity_Lightmap_HDR.xxx * u_xlat16_1.xyz + u_xlat16_11.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_39 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_7.xyz = vec3(u_xlat16_39) * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3.y;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD1.w = u_xlat0.x;
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
    vs_TEXCOORD1.y = u_xlat0.x * u_xlat1.w;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD1.z = u_xlat1.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD2.yz = u_xlat1.wy;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat0.y;
    vs_TEXCOORD3.w = u_xlat0.z;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3.y = max(u_xlat12, u_xlat16_3);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec3 u_xlat10;
float u_xlat18;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture2D(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat2.z = vs_TEXCOORD2.z;
    u_xlat2.x = vs_TEXCOORD3.z;
    u_xlat2.y = vs_TEXCOORD1.z;
    u_xlat3.y = vs_TEXCOORD3.x;
    u_xlat3.z = vs_TEXCOORD1.x;
    u_xlat3.x = vs_TEXCOORD2.x;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat2.xyz = u_xlat16_4.xzy * vs_TEXCOORD2.yyy;
    u_xlat3.y = u_xlat2.x;
    u_xlat3.xz = vs_TEXCOORD1.xz;
    u_xlat10_5.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat5.y = u_xlat2.z;
    u_xlat5.xz = vs_TEXCOORD2.xz;
    u_xlat3.y = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat2.xz = vs_TEXCOORD3.xz;
    u_xlat3.z = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat2.x = vs_TEXCOORD1.w;
    u_xlat2.y = vs_TEXCOORD2.w;
    u_xlat2.z = vs_TEXCOORD3.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * _NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat3.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat10.x = u_xlat26 * u_xlat26;
    u_xlat18 = (-_Smoothness) + 1.0;
    u_xlat26 = u_xlat18 * u_xlat18;
    u_xlat27 = u_xlat26 * u_xlat26 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat27 + 1.00001001;
    u_xlat27 = u_xlat18 * u_xlat18 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat27;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat2.x = u_xlat26 / u_xlat2.x;
    u_xlat16_24 = u_xlat18 * u_xlat26;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat10_5 = texture2D(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat2.xyw = u_xlat2.xyw * u_xlat16_6.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlatb27 = u_xlat18<0.00499999989;
    u_xlat18 = u_xlat18 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat18;
    u_xlat16_8 = dot((-u_xlat3.xyz), u_xlat1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_6.xyz = u_xlat1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat1.x) + 1.0;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_8 * u_xlat16_8;
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat1.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_6.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat1.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat25) + u_xlat16_6.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat1.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat1.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat25 = vs_TEXCOORD3.y;
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
  GpuProgramID 97581
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat13;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_3.xyz * vec3(u_xlat16_21) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
    vs_TEXCOORD1.y = u_xlat2.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat2.y;
    vs_TEXCOORD3.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat13;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_3.xyz * vec3(u_xlat16_21) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD7 = max(u_xlat0.x, u_xlat16_2);
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0.xyz = texture2D(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat10_3.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD7;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD7 = max(u_xlat0.x, u_xlat16_2);
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat13;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_3.xyz * vec3(u_xlat16_21) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD7;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD6;
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
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD7 = max(u_xlat0.x, u_xlat16_2);
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
    vs_TEXCOORD1.y = u_xlat3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat3.y;
    vs_TEXCOORD3.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _SphereMap;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD7;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_7;
float u_xlat13;
float u_xlat18;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat10_2.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat4.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_1.xyz = texture2D(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz + u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-1.22091627, -1.22091627, -1.22091627);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_3.xyz * vec3(u_xlat16_21) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD7;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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