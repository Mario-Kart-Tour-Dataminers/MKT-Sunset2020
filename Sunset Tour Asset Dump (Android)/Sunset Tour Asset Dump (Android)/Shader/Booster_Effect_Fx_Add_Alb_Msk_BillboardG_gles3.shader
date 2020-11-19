//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_Alb_Msk_BillboardG" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTexture ("A(UV0)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 8704
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-_WorldSpaceCameraPos.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-_WorldSpaceCameraPos.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-_WorldSpaceCameraPos.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * in_POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_AlphaTexture, vs_TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat1 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0.x * u_xlat1.w;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
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